static int multiSelect(Parse *pParse, /* Parsing context */
                       Select *p, /* The right-most of SELECTs to be coded */
                       SelectDest *pDest /* What to do with query results */
) {
  int rc = SQLITE_OK;  /* Success code from a subroutine */
  Select *pPrior;      /* Another SELECT immediately to our left */
  Vdbe *v;             /* Generate code to this VDBE */
  SelectDest dest;     /* Alternative data destination */
  Select *pDelete = 0; /* Chain of simple selects to delete */
  sqlite3 *db;         /* Database connection */

  /* Make sure there is no ORDER BY or LIMIT clause on prior SELECTs.  Only
  ** the last (right-most) SELECT in the series may have an ORDER BY or LIMIT.
  */
  assert(p && p->pPrior); /* Calling function guarantees this much */
  assert((p->selFlags & SF_Recursive) == 0 || p->op == TK_ALL ||
         p->op == TK_UNION);
  assert(p->selFlags & SF_Compound);
  db = pParse->db;
  pPrior = p->pPrior;
  dest = *pDest;
  assert(pPrior->pOrderBy == 0);
  assert(pPrior->pLimit == 0);

  v = sqlite3GetVdbe(pParse);
  assert(v != 0); /* The VDBE already created by calling function */

  /* Create the destination temporary table if necessary
   */
  if (dest.eDest == SRT_EphemTab) {
    assert(p->pEList);
    sqlite3VdbeAddOp2(v, OP_OpenEphemeral, dest.iSDParm, p->pEList->nExpr);
    dest.eDest = SRT_Table;
  }

  /* Special handling for a compound-select that originates as a VALUES clause.
   */
  if (p->selFlags & SF_MultiValue) {
    rc = multiSelectValues(pParse, p, &dest);
    if (rc >= 0)
      goto multi_select_end;
    rc = SQLITE_OK;
  }

  /* Make sure all SELECTs in the statement have the same number of elements
  ** in their result sets.
  */
  assert(p->pEList && pPrior->pEList);
  assert(p->pEList->nExpr == pPrior->pEList->nExpr);

#ifndef SQLITE_OMIT_CTE
  if ((p->selFlags & SF_Recursive) != 0 && hasAnchor(p)) {
    generateWithRecursiveQuery(pParse, p, &dest);
  } else
#endif

    /* Compound SELECTs that have an ORDER BY clause are handled separately.
     */
    if (p->pOrderBy) {
      return multiSelectOrderBy(pParse, p, pDest);
    } else {

#ifndef SQLITE_OMIT_EXPLAIN
      if (pPrior->pPrior == 0) {
        ExplainQueryPlan((pParse, 1, "COMPOUND QUERY"));
        ExplainQueryPlan((pParse, 1, "LEFT-MOST SUBQUERY"));
      }
#endif

      /* Generate code for the left and right SELECT statements.
       */
      switch (p->op) {
      case TK_ALL: {
        int addr = 0;
        int nLimit = 0; /* Initialize to suppress harmless compiler warning */
        assert(!pPrior->pLimit);
        pPrior->iLimit = p->iLimit;
        pPrior->iOffset = p->iOffset;
        pPrior->pLimit = p->pLimit;
        SELECTTRACE(1, pParse, p, ("multiSelect UNION ALL left...\n"));
        rc = sqlite3Select(pParse, pPrior, &dest);
        pPrior->pLimit = 0;
        if (rc) {
          goto multi_select_end;
        }
        p->pPrior = 0;
        p->iLimit = pPrior->iLimit;
        p->iOffset = pPrior->iOffset;
        if (p->iLimit) {
          addr = sqlite3VdbeAddOp1(v, OP_IfNot, p->iLimit);
          VdbeCoverage(v);
          VdbeComment((v, "Jump ahead if LIMIT reached"));
          if (p->iOffset) {
            sqlite3VdbeAddOp3(v, OP_OffsetLimit, p->iLimit, p->iOffset + 1,
                              p->iOffset);
          }
        }
        ExplainQueryPlan((pParse, 1, "UNION ALL"));
        SELECTTRACE(1, pParse, p, ("multiSelect UNION ALL right...\n"));
        rc = sqlite3Select(pParse, p, &dest);
        testcase(rc != SQLITE_OK);
        pDelete = p->pPrior;
        p->pPrior = pPrior;
        p->nSelectRow = sqlite3LogEstAdd(p->nSelectRow, pPrior->nSelectRow);
        if (p->pLimit && sqlite3ExprIsInteger(p->pLimit->pLeft, &nLimit) &&
            nLimit > 0 && p->nSelectRow > sqlite3LogEst((u64)nLimit)) {
          p->nSelectRow = sqlite3LogEst((u64)nLimit);
        }
        if (addr) {
          sqlite3VdbeJumpHere(v, addr);
        }
        break;
      }
      case TK_EXCEPT:
      case TK_UNION: {
        int unionTab; /* Cursor number of the temp table holding result */
        u8 op = 0;    /* One of the SRT_ operations to apply to self */
        int priorOp;  /* The SRT_ operation to apply to prior selects */
        Expr *pLimit; /* Saved values of p->nLimit  */
        int addr;
        SelectDest uniondest;

        testcase(p->op == TK_EXCEPT);
        testcase(p->op == TK_UNION);
        priorOp = SRT_Union;
        if (dest.eDest == priorOp) {
          /* We can reuse a temporary table generated by a SELECT to our
          ** right.
          */
          assert(p->pLimit == 0); /* Not allowed on leftward elements */
          unionTab = dest.iSDParm;
        } else {
          /* We will need to create our own temporary table to hold the
          ** intermediate results.
          */
          unionTab = pParse->nTab++;
          assert(p->pOrderBy == 0);
          addr = sqlite3VdbeAddOp2(v, OP_OpenEphemeral, unionTab, 0);
          assert(p->addrOpenEphm[0] == -1);
          p->addrOpenEphm[0] = addr;
          findRightmost(p)->selFlags |= SF_UsesEphemeral;
          assert(p->pEList);
        }

        /* Code the SELECT statements to our left
         */
        assert(!pPrior->pOrderBy);
        sqlite3SelectDestInit(&uniondest, priorOp, unionTab);
        SELECTTRACE(1, pParse, p, ("multiSelect EXCEPT/UNION left...\n"));
        rc = sqlite3Select(pParse, pPrior, &uniondest);
        if (rc) {
          goto multi_select_end;
        }

        /* Code the current SELECT statement
         */
        if (p->op == TK_EXCEPT) {
          op = SRT_Except;
        } else {
          assert(p->op == TK_UNION);
          op = SRT_Union;
        }
        p->pPrior = 0;
        pLimit = p->pLimit;
        p->pLimit = 0;
        uniondest.eDest = op;
        ExplainQueryPlan(
            (pParse, 1, "%s USING TEMP B-TREE", sqlite3SelectOpName(p->op)));
        SELECTTRACE(1, pParse, p, ("multiSelect EXCEPT/UNION right...\n"));
        rc = sqlite3Select(pParse, p, &uniondest);
        testcase(rc != SQLITE_OK);
        assert(p->pOrderBy == 0);
        pDelete = p->pPrior;
        p->pPrior = pPrior;
        p->pOrderBy = 0;
        if (p->op == TK_UNION) {
          p->nSelectRow = sqlite3LogEstAdd(p->nSelectRow, pPrior->nSelectRow);
        }
        sqlite3ExprDelete(db, p->pLimit);
        p->pLimit = pLimit;
        p->iLimit = 0;
        p->iOffset = 0;

        /* Convert the data in the temporary table into whatever form
        ** it is that we currently need.
        */
        assert(unionTab == dest.iSDParm || dest.eDest != priorOp);
        assert(p->pEList || db->mallocFailed);
        if (dest.eDest != priorOp && db->mallocFailed == 0) {
          int iCont, iBreak, iStart;
          iBreak = sqlite3VdbeMakeLabel(pParse);
          iCont = sqlite3VdbeMakeLabel(pParse);
          computeLimitRegisters(pParse, p, iBreak);
          sqlite3VdbeAddOp2(v, OP_Rewind, unionTab, iBreak);
          VdbeCoverage(v);
          iStart = sqlite3VdbeCurrentAddr(v);
          selectInnerLoop(pParse, p, unionTab, 0, 0, &dest, iCont, iBreak);
          sqlite3VdbeResolveLabel(v, iCont);
          sqlite3VdbeAddOp2(v, OP_Next, unionTab, iStart);
          VdbeCoverage(v);
          sqlite3VdbeResolveLabel(v, iBreak);
          sqlite3VdbeAddOp2(v, OP_Close, unionTab, 0);
        }
        break;
      }
      default:
        assert(p->op == TK_INTERSECT);
        {
          int tab1, tab2;
          int iCont, iBreak, iStart;
          Expr *pLimit;
          int addr;
          SelectDest intersectdest;
          int r1;

          /* INTERSECT is different from the others since it requires
          ** two temporary tables.  Hence it has its own case.  Begin
          ** by allocating the tables we will need.
          */
          tab1 = pParse->nTab++;
          tab2 = pParse->nTab++;
          assert(p->pOrderBy == 0);

          addr = sqlite3VdbeAddOp2(v, OP_OpenEphemeral, tab1, 0);
          assert(p->addrOpenEphm[0] == -1);
          p->addrOpenEphm[0] = addr;
          findRightmost(p)->selFlags |= SF_UsesEphemeral;
          assert(p->pEList);

          /* Code the SELECTs to our left into temporary table "tab1".
           */
          sqlite3SelectDestInit(&intersectdest, SRT_Union, tab1);
          SELECTTRACE(1, pParse, p, ("multiSelect INTERSECT left...\n"));
          rc = sqlite3Select(pParse, pPrior, &intersectdest);
          if (rc) {
            goto multi_select_end;
          }

          /* Code the current SELECT into temporary table "tab2"
           */
          addr = sqlite3VdbeAddOp2(v, OP_OpenEphemeral, tab2, 0);
          assert(p->addrOpenEphm[1] == -1);
          p->addrOpenEphm[1] = addr;
          p->pPrior = 0;
          pLimit = p->pLimit;
          p->pLimit = 0;
          intersectdest.iSDParm = tab2;
          ExplainQueryPlan(
              (pParse, 1, "%s USING TEMP B-TREE", sqlite3SelectOpName(p->op)));
          SELECTTRACE(1, pParse, p, ("multiSelect INTERSECT right...\n"));
          rc = sqlite3Select(pParse, p, &intersectdest);
          testcase(rc != SQLITE_OK);
          pDelete = p->pPrior;
          p->pPrior = pPrior;
          if (p->nSelectRow > pPrior->nSelectRow) {
            p->nSelectRow = pPrior->nSelectRow;
          }
          sqlite3ExprDelete(db, p->pLimit);
          p->pLimit = pLimit;

          /* Generate code to take the intersection of the two temporary
          ** tables.
          */
          if (rc)
            break;
          assert(p->pEList);
          iBreak = sqlite3VdbeMakeLabel(pParse);
          iCont = sqlite3VdbeMakeLabel(pParse);
          computeLimitRegisters(pParse, p, iBreak);
          sqlite3VdbeAddOp2(v, OP_Rewind, tab1, iBreak);
          VdbeCoverage(v);
          r1 = sqlite3GetTempReg(pParse);
          iStart = sqlite3VdbeAddOp2(v, OP_RowData, tab1, r1);
          sqlite3VdbeAddOp4Int(v, OP_NotFound, tab2, iCont, r1, 0);
          VdbeCoverage(v);
          sqlite3ReleaseTempReg(pParse, r1);
          selectInnerLoop(pParse, p, tab1, 0, 0, &dest, iCont, iBreak);
          sqlite3VdbeResolveLabel(v, iCont);
          sqlite3VdbeAddOp2(v, OP_Next, tab1, iStart);
          VdbeCoverage(v);
          sqlite3VdbeResolveLabel(v, iBreak);
          sqlite3VdbeAddOp2(v, OP_Close, tab2, 0);
          sqlite3VdbeAddOp2(v, OP_Close, tab1, 0);
          break;
        }
      }

#ifndef SQLITE_OMIT_EXPLAIN
      if (p->pNext == 0) {
        ExplainQueryPlanPop(pParse);
      }
#endif
    }
  if (pParse->nErr)
    goto multi_select_end;
  /* Compute collating sequences used by
  ** temporary tables needed to implement the compound select.
  ** Attach the KeyInfo structure to all temporary tables.
  **
  ** This section is run by the right-most SELECT statement only.
  ** SELECT statements to the left always skip this part.  The right-most
  ** SELECT might also skip this part if it has no ORDER BY clause and
  ** no temp tables are required.
  */
  if (p->selFlags & SF_UsesEphemeral) {
    int i;             /* Loop counter */
    KeyInfo *pKeyInfo; /* Collating sequence for the result set */
    Select *pLoop;     /* For looping through SELECT statements */
    CollSeq **apColl;  /* For looping through pKeyInfo->aColl[] */
    int nCol;          /* Number of columns in result set */

    assert(p->pNext == 0);
    nCol = p->pEList->nExpr;
    pKeyInfo = sqlite3KeyInfoAlloc(db, nCol, 1);
    if (!pKeyInfo) {
      rc = SQLITE_NOMEM_BKPT;
      goto multi_select_end;
    }
    for (i = 0, apColl = pKeyInfo->aColl; i < nCol; i++, apColl++) {
      *apColl = multiSelectCollSeq(pParse, p, i);
      if (0 == *apColl) {
        *apColl = db->pDfltColl;
      }
    }

    for (pLoop = p; pLoop; pLoop = pLoop->pPrior) {
      for (i = 0; i < 2; i++) {
        int addr = pLoop->addrOpenEphm[i];
        if (addr < 0) {
          /* If [0] is unused then [1] is also unused.  So we can
          ** always safely abort as soon as the first unused slot is found */
          assert(pLoop->addrOpenEphm[1] < 0);
          break;
        }
        sqlite3VdbeChangeP2(v, addr, nCol);
        sqlite3VdbeChangeP4(v, addr, (char *)sqlite3KeyInfoRef(pKeyInfo),
                            P4_KEYINFO);
        pLoop->addrOpenEphm[i] = -1;
      }
    }
    sqlite3KeyInfoUnref(pKeyInfo);
  }

multi_select_end:
  pDest->iSdst = dest.iSdst;
  pDest->nSdst = dest.nSdst;
  sqlite3SelectDelete(db, pDelete);
  return rc;
}