static int selectExpander(Walker *pWalker, Select *p) {
  Parse *pParse = pWalker->pParse;
  int i, j, k, rc;
  SrcList *pTabList;
  ExprList *pEList;
  SrcItem *pFrom;
  sqlite3 *db = pParse->db;
  Expr *pE, *pRight, *pExpr;
  u16 selFlags = p->selFlags;
  u32 elistFlags = 0;

  p->selFlags |= SF_Expanded;
  if (db->mallocFailed) {
    return WRC_Abort;
  }
  assert(p->pSrc != 0);
  if ((selFlags & SF_Expanded) != 0) {
    return WRC_Prune;
  }
  if (pWalker->eCode) {
    /* Renumber selId because it has been copied from a view */
    p->selId = ++pParse->nSelect;
  }
  pTabList = p->pSrc;
  pEList = p->pEList;
  if (pParse->pWith && (p->selFlags & SF_View)) {
    if (p->pWith == 0) {
      p->pWith = (With *)sqlite3DbMallocZero(db, sizeof(With));
      if (p->pWith == 0) {
        return WRC_Abort;
      }
    }
    p->pWith->bView = 1;
  }
  sqlite3WithPush(pParse, p->pWith, 0);

  /* Make sure cursor numbers have been assigned to all entries in
  ** the FROM clause of the SELECT statement.
  */
  sqlite3SrcListAssignCursors(pParse, pTabList);

  /* Look up every table named in the FROM clause of the select.  If
  ** an entry of the FROM clause is a subquery instead of a table or view,
  ** then create a transient table structure to describe the subquery.
  */
  for (i = 0, pFrom = pTabList->a; i < pTabList->nSrc; i++, pFrom++) {
    Table *pTab;
    assert(pFrom->fg.isRecursive == 0 || pFrom->pTab != 0);
    if (pFrom->pTab)
      continue;
    assert(pFrom->fg.isRecursive == 0);
    if (pFrom->zName == 0) {
#ifndef SQLITE_OMIT_SUBQUERY
      Select *pSel = pFrom->pSelect;
      /* A sub-query in the FROM clause of a SELECT */
      assert(pSel != 0);
      assert(pFrom->pTab == 0);
      if (sqlite3WalkSelect(pWalker, pSel))
        return WRC_Abort;
      if (sqlite3ExpandSubquery(pParse, pFrom))
        return WRC_Abort;
#endif
#ifndef SQLITE_OMIT_CTE
    } else if ((rc = resolveFromTermToCte(pParse, pWalker, pFrom)) != 0) {
      if (rc > 1)
        return WRC_Abort;
      pTab = pFrom->pTab;
      assert(pTab != 0);
#endif
    } else {
      /* An ordinary table or view name in the FROM clause */
      assert(pFrom->pTab == 0);
      pFrom->pTab = pTab = sqlite3LocateTableItem(pParse, 0, pFrom);
      if (pTab == 0)
        return WRC_Abort;
      if (pTab->nTabRef >= 0xffff) {
        sqlite3ErrorMsg(pParse, "too many references to \"%s\": max 65535",
                        pTab->zName);
        pFrom->pTab = 0;
        return WRC_Abort;
      }
      pTab->nTabRef++;
      if (!IsVirtual(pTab) && cannotBeFunction(pParse, pFrom)) {
        return WRC_Abort;
      }
#if !defined(SQLITE_OMIT_VIEW) || !defined(SQLITE_OMIT_VIRTUALTABLE)
      if (IsVirtual(pTab) || pTab->pSelect) {
        i16 nCol;
        u8 eCodeOrig = pWalker->eCode;
        if (sqlite3ViewGetColumnNames(pParse, pTab))
          return WRC_Abort;
        assert(pFrom->pSelect == 0);
        if (pTab->pSelect && (db->flags & SQLITE_EnableView) == 0 &&
            pTab->pSchema != db->aDb[1].pSchema) {
          sqlite3ErrorMsg(pParse, "access to view \"%s\" prohibited",
                          pTab->zName);
        }
#ifndef SQLITE_OMIT_VIRTUALTABLE
        assert(SQLITE_VTABRISK_Normal == 1 && SQLITE_VTABRISK_High == 2);
        if (IsVirtual(pTab) && pFrom->fg.fromDDL &&
            ALWAYS(pTab->pVTable != 0) &&
            pTab->pVTable->eVtabRisk >
                ((db->flags & SQLITE_TrustedSchema) != 0)) {
          sqlite3ErrorMsg(pParse, "unsafe use of virtual table \"%s\"",
                          pTab->zName);
        }
#endif
        pFrom->pSelect = sqlite3SelectDup(db, pTab->pSelect, 0);
        nCol = pTab->nCol;
        pTab->nCol = -1;
        pWalker->eCode = 1; /* Turn on Select.selId renumbering */
        sqlite3WalkSelect(pWalker, pFrom->pSelect);
        pWalker->eCode = eCodeOrig;
        pTab->nCol = nCol;
      }
#endif
    }

    /* Locate the index named by the INDEXED BY clause, if any. */
    if (pFrom->fg.isIndexedBy && sqlite3IndexedByLookup(pParse, pFrom)) {
      return WRC_Abort;
    }
  }

  /* Process NATURAL keywords, and ON and USING clauses of joins.
   */
  if (
      pParse->nErr ||
      db->mallocFailed || sqliteProcessJoin(pParse, p)) {
    return WRC_Abort;
  }

  /* For every "*" that occurs in the column list, insert the names of
  ** all columns in all tables.  And for every TABLE.* insert the names
  ** of all columns in TABLE.  The parser inserted a special expression
  ** with the TK_ASTERISK operator for each "*" that it found in the column
  ** list.  The following code just has to locate the TK_ASTERISK
  ** expressions and expand each one to the list of all columns in
  ** all tables.
  **
  ** The first loop just checks to see if there are any "*" operators
  ** that need expanding.
  */
  for (k = 0; k < pEList->nExpr; k++) {
    pE = pEList->a[k].pExpr;
    if (pE->op == TK_ASTERISK)
      break;
    assert(pE->op != TK_DOT || pE->pRight != 0);
    assert(pE->op != TK_DOT || (pE->pLeft != 0 && pE->pLeft->op == TK_ID));
    if (pE->op == TK_DOT && pE->pRight->op == TK_ASTERISK)
      break;
    elistFlags |= pE->flags;
  }
  if (k < pEList->nExpr) {
    /*
    ** If we get here it means the result set contains one or more "*"
    ** operators that need to be expanded.  Loop through each expression
    ** in the result set and expand them one by one.
    */
    struct ExprList_item *a = pEList->a;
    ExprList *pNew = 0;
    int flags = pParse->db->flags;
    int longNames = (flags & SQLITE_FullColNames) != 0 &&
                    (flags & SQLITE_ShortColNames) == 0;

    for (k = 0; k < pEList->nExpr; k++) {
      pE = a[k].pExpr;
      elistFlags |= pE->flags;
      pRight = pE->pRight;
      assert(pE->op != TK_DOT || pRight != 0);
      if (pE->op != TK_ASTERISK &&
          (pE->op != TK_DOT || pRight->op != TK_ASTERISK)) {
        /* This particular expression does not need to be expanded.
         */
        pNew = sqlite3ExprListAppend(pParse, pNew, a[k].pExpr);
        if (pNew) {
          pNew->a[pNew->nExpr - 1].zEName = a[k].zEName;
          pNew->a[pNew->nExpr - 1].eEName = a[k].eEName;
          a[k].zEName = 0;
        }
        a[k].pExpr = 0;
      } else {
        /* This expression is a "*" or a "TABLE.*" and needs to be
        ** expanded. */
        int tableSeen = 0; /* Set to 1 when TABLE matches */
        char *zTName = 0;  /* text of name of TABLE */
        if (pE->op == TK_DOT) {
          assert(pE->pLeft != 0);
          assert(!ExprHasProperty(pE->pLeft, EP_IntValue));
          zTName = pE->pLeft->u.zToken;
        }
        for (i = 0, pFrom = pTabList->a; i < pTabList->nSrc; i++, pFrom++) {
          Table *pTab = pFrom->pTab;
          Select *pSub = pFrom->pSelect;
          char *zTabName = pFrom->zAlias;
          const char *zSchemaName = 0;
          int iDb;
          if (zTabName == 0) {
            zTabName = pTab->zName;
          }
          if (db->mallocFailed)
            break;
          if (pSub == 0 || (pSub->selFlags & SF_NestedFrom) == 0) {
            pSub = 0;
            if (zTName && sqlite3StrICmp(zTName, zTabName) != 0) {
              continue;
            }
            iDb = sqlite3SchemaToIndex(db, pTab->pSchema);
            zSchemaName = iDb >= 0 ? db->aDb[iDb].zDbSName : "*";
          }
          for (j = 0; j < pTab->nCol; j++) {
            char *zName = pTab->aCol[j].zName;
            char *zColname; /* The computed column name */
            char *zToFree;  /* Malloced string that needs to be freed */
            Token sColname; /* Computed column name as a token */

            assert(zName);
            if (zTName && pSub &&
                sqlite3MatchEName(&pSub->pEList->a[j], 0, zTName, 0) == 0) {
              continue;
            }

            /* If a column is marked as 'hidden', omit it from the expanded
            ** result-set list unless the SELECT has the SF_IncludeHidden
            ** bit set.
            */
            if ((p->selFlags & SF_IncludeHidden) == 0 &&
                IsHiddenColumn(&pTab->aCol[j])) {
              continue;
            }
            tableSeen = 1;

            if (i > 0 && zTName == 0) {
              if ((pFrom->fg.jointype & JT_NATURAL) != 0 &&
                  tableAndColumnIndex(pTabList, i, zName, 0, 0, 1)) {
                /* In a NATURAL join, omit the join columns from the
                ** table to the right of the join */
                continue;
              }
              if (sqlite3IdListIndex(pFrom->pUsing, zName) >= 0) {
                /* In a join with a USING clause, omit columns in the
                ** using clause from the table on the right. */
                continue;
              }
            }
            pRight = sqlite3Expr(db, TK_ID, zName);
            zColname = zName;
            zToFree = 0;
            if (longNames || pTabList->nSrc > 1) {
              Expr *pLeft;
              pLeft = sqlite3Expr(db, TK_ID, zTabName);
              pExpr = sqlite3PExpr(pParse, TK_DOT, pLeft, pRight);
              if (zSchemaName) {
                pLeft = sqlite3Expr(db, TK_ID, zSchemaName);
                pExpr = sqlite3PExpr(pParse, TK_DOT, pLeft, pExpr);
              }
              if (longNames) {
                zColname = sqlite3MPrintf(db, "%s.%s", zTabName, zName);
                zToFree = zColname;
              }
            } else {
              pExpr = pRight;
            }
            pNew = sqlite3ExprListAppend(pParse, pNew, pExpr);
            sqlite3TokenInit(&sColname, zColname);
            sqlite3ExprListSetName(pParse, pNew, &sColname, 0);
            if (pNew && (p->selFlags & SF_NestedFrom) != 0 &&
                !IN_RENAME_OBJECT) {
              struct ExprList_item *pX = &pNew->a[pNew->nExpr - 1];
              sqlite3DbFree(db, pX->zEName);
              if (pSub) {
                pX->zEName = sqlite3DbStrDup(db, pSub->pEList->a[j].zEName);
                testcase(pX->zEName == 0);
              } else {
                pX->zEName = sqlite3MPrintf(db, "%s.%s.%s", zSchemaName,
                                            zTabName, zColname);
                testcase(pX->zEName == 0);
              }
              pX->eEName = ENAME_TAB;
            }
            sqlite3DbFree(db, zToFree);
          }
        }
        if (!tableSeen) {
          if (zTName) {
            sqlite3ErrorMsg(pParse, "no such table: %s", zTName);
          } else {
            sqlite3ErrorMsg(pParse, "no tables specified");
          }
        }
      }
    }
    sqlite3ExprListDelete(db, pEList);
    p->pEList = pNew;
  }
  if (p->pEList) {
    if (p->pEList->nExpr > db->aLimit[SQLITE_LIMIT_COLUMN]) {
      sqlite3ErrorMsg(pParse, "too many columns in result set");
      return WRC_Abort;
    }
    if ((elistFlags & (EP_HasFunc | EP_Subquery)) != 0) {
      p->selFlags |= SF_ComplexResult;
    }
  }
  return WRC_Continue;
}
