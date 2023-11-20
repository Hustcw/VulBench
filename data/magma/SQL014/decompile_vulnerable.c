int __fastcall multiSelect(Parse *pParse, Select *p, SelectDest *pDest)
{
  Select *v3;
  Select *pPrior;
  SelectDest *v5;
  Parse *v6;
  u32 selFlags;
  sqlite3 *db;
  __int128 v9;
  Vdbe *Vdbe;
  Vdbe *v11;
  ExprList *pEList;
  int v13;
  Select *v14;
  int v15;
  ExprList *v16;
  ExprList *v17;
  int iSDParm;
  int iLimit;
  int v20;
  int iOffset;
  int v22;
  int v23;
  Select *v24;
  int v25;
  int v26;
  Expr *v27;
  const char *v28;
  LogEst v29;
  unsigned int v30;
  __int64 v31;
  int TempReg;
  int v33;
  int v34;
  int nTab;
  int v36;
  Select *Rightmost;
  int v38;
  int op;
  u8 v40;
  Expr *pLimit;
  const char *v42;
  int v43;
  int v44;
  int Label;
  int v46;
  int v47;
  int v48;
  Expr *v49;
  LogEst nSelectRow;
  LogEst v51;
  int nExpr;
  KeyInfo *v53;
  KeyInfo *v54;
  __int64 v55;
  CollSeq *v56;
  int v57;
  KeyInfo *v58;
  int v59;
  KeyInfo *v60;
  sqlite3 *v63;
  sqlite3 *v64;
  sqlite3 *v65;
  int v66;
  Select *v67;
  Select *v68;
  Select *v69;
  Select *v70;
  int v71;
  int v72;
  int iParm;
  int iParma;
  int iParmb;
  SelectDest *v76;
  SelectDest *v77;
  int v78;
  SelectDest p1;
  int p2[2];
  int x[2];
  SelectDest v82;

  if ( !p || (v3 = p, (pPrior = p->pPrior) == 0LL) )
    __assert_fail("p && p->pPrior", "sqlite3.c", 0x20F78u, "int multiSelect(Parse *, Select *, SelectDest *)");
  v5 = pDest;
  v6 = pParse;
  selFlags = p->selFlags;
  if ( (selFlags & 0x2000) != 0 && (unsigned __int8)(p->op + 123) >= 2u )
    __assert_fail(
      "(p->selFlags & SF_Recursive)==0 || p->op==TK_ALL || p->op==TK_UNION",
      "sqlite3.c",
      0x20F79u,
      "int multiSelect(Parse *, Select *, SelectDest *)");
  if ( (selFlags & 0x100) == 0 )
    __assert_fail(
      "p->selFlags & SF_Compound",
      "sqlite3.c",
      0x20F7Au,
      "int multiSelect(Parse *, Select *, SelectDest *)");
  db = pParse->db;
  p1.pOrderBy = pDest->pOrderBy;
  v9 = *(_OWORD *)&pDest->eDest;
  *(_OWORD *)&p1.nSdst = *(_OWORD *)&pDest->nSdst;
  *(_OWORD *)&p1.eDest = v9;
  if ( pPrior->pOrderBy )
    __assert_fail("pPrior->pOrderBy==0", "sqlite3.c", 0x20F7Eu, "int multiSelect(Parse *, Select *, SelectDest *)");
  if ( pPrior->pLimit )
    __assert_fail("pPrior->pLimit==0", "sqlite3.c", 0x20F7Fu, "int multiSelect(Parse *, Select *, SelectDest *)");
  Vdbe = sqlite3GetVdbe(pParse);
  if ( !Vdbe )
    __assert_fail("v!=0", "sqlite3.c", 0x20F82u, "int multiSelect(Parse *, Select *, SelectDest *)");
  v11 = Vdbe;
  if ( p1.eDest == 12 )
  {
    pEList = p->pEList;
    if ( !pEList )
      __assert_fail("p->pEList", "sqlite3.c", 0x20F87u, "int multiSelect(Parse *, Select *, SelectDest *)");
    sqlite3VdbeAddOp2(v11, 112, p1.iSDParm, pEList->nExpr);
    p1.eDest = 14;
  }
  if ( (p->selFlags & 0x400) != 0 )
  {
    v13 = multiSelectValues(pParse, p, &p1);
    if ( v13 >= 0 )
    {
LABEL_14:
      v14 = 0LL;
      v15 = v13;
multi_select_end:
      v5->iSdst = p1.iSdst;
      v5->nSdst = p1.nSdst;
      sqlite3SelectDelete(db, v14);
      return v15;
    }
  }
  v16 = p->pEList;
  if ( !v16 || (v17 = pPrior->pEList) == 0LL )
    __assert_fail(
      "p->pEList && pPrior->pEList",
      "sqlite3.c",
      0x20F97u,
      "int multiSelect(Parse *, Select *, SelectDest *)");
  if ( v16->nExpr != v17->nExpr )
    __assert_fail(
      "p->pEList->nExpr==pPrior->pEList->nExpr",
      "sqlite3.c",
      0x20F98u,
      "int multiSelect(Parse *, Select *, SelectDest *)");
  if ( (p->selFlags & 0x2000) != 0 && hasAnchor(p) )
  {
    generateWithRecursiveQuery(pParse, p, &p1);
    v14 = 0LL;
    v66 = 0;
LABEL_21:
    if ( (v3->selFlags & 0x20) != 0 )
    {
LABEL_80:
      v70 = v14;
      v77 = v5;
      if ( v3->pNext )
        __assert_fail("p->pNext==0", "sqlite3.c", 0x210A0u, "int multiSelect(Parse *, Select *, SelectDest *)");
      nExpr = v3->pEList->nExpr;
      v65 = db;
      v53 = sqlite3KeyInfoAlloc(db, nExpr, 1);
      if ( v53 )
      {
        v54 = v53;
        if ( nExpr > 0 )
        {
          v55 = 0LL;
          do
          {
            v56 = multiSelectCollSeq(v6, v3, v55);
            v54->aColl[v55] = v56;
            if ( !v56 )
              v54->aColl[v55] = v65->pDfltColl;
            ++v55;
          }
          while ( nExpr != (_DWORD)v55 );
        }
        do
        {
          v57 = v3->addrOpenEphm[0];
          if ( v57 < 0 )
          {
            if ( v3->addrOpenEphm[1] >= 0 )
              __assert_fail(
                "pLoop->addrOpenEphm[1]<0",
                "sqlite3.c",
                0x210B4u,
                "int multiSelect(Parse *, Select *, SelectDest *)");
          }
          else
          {
            sqlite3VdbeChangeP2(v11, v57, nExpr);
            v58 = sqlite3KeyInfoRef(v54);
            sqlite3VdbeChangeP4(v11, v57, (const char *)v58, -9);
            v3->addrOpenEphm[0] = -1;
            v59 = v3->addrOpenEphm[1];
            if ( v59 >= 0 )
            {
              sqlite3VdbeChangeP2(v11, v59, nExpr);
              v60 = sqlite3KeyInfoRef(v54);
              sqlite3VdbeChangeP4(v11, v59, (const char *)v60, -9);
              v3->addrOpenEphm[1] = -1;
            }
          }
          v3 = v3->pPrior;
        }
        while ( v3 );
        sqlite3KeyInfoUnref(v54);
        v5 = v77;
        db = v65;
        v15 = v66;
      }
      else
      {
        v15 = sqlite3NomemError(135332);
      }
      v14 = v70;
    }
    else
    {
LABEL_22:
      v15 = v66;
    }
    goto multi_select_end;
  }
  if ( !p->pOrderBy )
  {
    if ( !pPrior->pPrior )
    {
      sqlite3VdbeExplain(pParse, 1u, "COMPOUND QUERY");
      sqlite3VdbeExplain(pParse, 1u, "LEFT-MOST SUBQUERY");
    }
    switch ( p->op )
    {
      case 0x85:
      case 0x87:
        if ( p1.eDest == 1 )
        {
          if ( p->pLimit )
            __assert_fail("p->pLimit==0", "sqlite3.c", 0x20FEAu, "int multiSelect(Parse *, Select *, SelectDest *)");
          iSDParm = p1.iSDParm;
        }
        else
        {
          nTab = pParse->nTab;
          pParse->nTab = nTab + 1;
          if ( p->pOrderBy )
            __assert_fail("p->pOrderBy==0", "sqlite3.c", 0x20FF1u, "int multiSelect(Parse *, Select *, SelectDest *)");
          iParma = nTab;
          v36 = sqlite3VdbeAddOp2(v11, 112, nTab, 0);
          if ( p->addrOpenEphm[0] != -1 )
            __assert_fail(
              "p->addrOpenEphm[0] == -1",
              "sqlite3.c",
              0x20FF3u,
              "int multiSelect(Parse *, Select *, SelectDest *)");
          p->addrOpenEphm[0] = v36;
          Rightmost = findRightmost(p);
          LOBYTE(Rightmost->selFlags) |= 0x20u;
          iSDParm = iParma;
          if ( !p->pEList )
            __assert_fail("p->pEList", "sqlite3.c", 0x20FF6u, "int multiSelect(Parse *, Select *, SelectDest *)");
        }
        v64 = db;
        if ( pPrior->pOrderBy )
          __assert_fail("!pPrior->pOrderBy", "sqlite3.c", 0x20FFCu, "int multiSelect(Parse *, Select *, SelectDest *)");
        v38 = iSDParm;
        sqlite3SelectDestInit(&v82, 1, iSDParm);
        v25 = sqlite3Select(pParse, pPrior, &v82);
        if ( v25 )
          goto LABEL_53;
        iParmb = v38;
        op = p->op;
        if ( op == 133 )
        {
          v40 = 1;
        }
        else
        {
          v40 = 2;
          if ( (_BYTE)op != 0x87 )
            __assert_fail("p->op==TK_UNION", "sqlite3.c", 0x21009u, "int multiSelect(Parse *, Select *, SelectDest *)");
        }
        p->pPrior = 0LL;
        pLimit = p->pLimit;
        p->pLimit = 0LL;
        v82.eDest = v40;
        v42 = sqlite3SelectOpName(op);
        sqlite3VdbeExplain(v6, 1u, "%s USING TEMP B-TREE", v42);
        v43 = sqlite3Select(v6, p, &v82);
        if ( p->pOrderBy )
          __assert_fail("p->pOrderBy==0", "sqlite3.c", 0x21015u, "int multiSelect(Parse *, Select *, SelectDest *)");
        v44 = v43;
        v68 = p->pPrior;
        p->pPrior = pPrior;
        p->pOrderBy = 0LL;
        if ( p->op == 0x85 )
          p->nSelectRow = sqlite3LogEstAdd(p->nSelectRow, pPrior->nSelectRow);
        v66 = v44;
        sqlite3ExprDelete(v64, p->pLimit);
        p->pLimit = pLimit;
        *(_QWORD *)&p->iLimit = 0LL;
        if ( iParmb != p1.iSDParm && p1.eDest == 1 )
          __assert_fail(
            "unionTab==dest.iSDParm || dest.eDest!=priorOp",
            "sqlite3.c",
            0x21024u,
            "int multiSelect(Parse *, Select *, SelectDest *)");
        v6 = pParse;
        db = v64;
        v14 = v68;
        if ( !p->pEList && !v64->mallocFailed )
          __assert_fail(
            "p->pEList || db->mallocFailed",
            "sqlite3.c",
            0x21025u,
            "int multiSelect(Parse *, Select *, SelectDest *)");
        if ( p1.eDest == 1 || v64->mallocFailed )
          goto LABEL_78;
        Label = sqlite3VdbeMakeLabel(pParse);
        v46 = sqlite3VdbeMakeLabel(pParse);
        computeLimitRegisters(pParse, p, Label);
        sqlite3VdbeAddOp2(v11, 37, iParmb, Label);
        v72 = sqlite3VdbeCurrentAddr(v11);
        selectInnerLoop(pParse, p, iParmb, 0LL, 0LL, &p1, v46, Label);
        v14 = v68;
        sqlite3VdbeResolveLabel(v11, v46);
        sqlite3VdbeAddOp2(v11, 5, iParmb, v72);
        v47 = Label;
        db = v64;
        v6 = pParse;
        sqlite3VdbeResolveLabel(v11, v47);
        sqlite3VdbeAddOp2(v11, 118, iParmb, 0);
        if ( !v3->pNext )
          goto LABEL_79;
        goto LABEL_21;
      case 0x86:
        *(_DWORD *)&v82.eDest = 0;
        if ( pPrior->pLimit )
          __assert_fail("!pPrior->pLimit", "sqlite3.c", 0x20FB3u, "int multiSelect(Parse *, Select *, SelectDest *)");
        pPrior->iLimit = p->iLimit;
        pPrior->iOffset = p->iOffset;
        pPrior->pLimit = p->pLimit;
        v13 = sqlite3Select(pParse, pPrior, &p1);
        pPrior->pLimit = 0LL;
        if ( v13 )
          goto LABEL_14;
        v63 = db;
        p->pPrior = 0LL;
        iLimit = pPrior->iLimit;
        p->iLimit = iLimit;
        p->iOffset = pPrior->iOffset;
        if ( iLimit )
        {
          v20 = sqlite3VdbeAddOp1(v11, 20, iLimit);
          sqlite3VdbeComment(v11, "Jump ahead if LIMIT reached");
          iOffset = p->iOffset;
          if ( iOffset )
            sqlite3VdbeAddOp3(v11, 156, p->iLimit, iOffset + 1, iOffset);
        }
        else
        {
          v20 = 0;
        }
        sqlite3VdbeExplain(pParse, 1u, "UNION ALL");
        v48 = sqlite3Select(pParse, p, &p1);
        v69 = p->pPrior;
        p->pPrior = pPrior;
        p->nSelectRow = sqlite3LogEstAdd(p->nSelectRow, pPrior->nSelectRow);
        v49 = p->pLimit;
        if ( v49 )
        {
          if ( sqlite3ExprIsInteger(v49->pLeft, (int *)&v82) )
          {
            if ( *(int *)&v82.eDest > 0 )
            {
              nSelectRow = p->nSelectRow;
              v51 = sqlite3LogEst(*(int *)&v82.eDest);
              if ( nSelectRow > v51 )
                p->nSelectRow = v51;
            }
          }
        }
        v66 = v48;
        if ( v20 )
          sqlite3VdbeJumpHere(v11, v20);
        v6 = pParse;
        db = v63;
        v14 = v69;
LABEL_78:
        if ( !p->pNext )
          goto LABEL_79;
        goto LABEL_21;
      case 0x88:
        v22 = pParse->nTab;
        pParse->nTab = v22 + 2;
        if ( p->pOrderBy )
          __assert_fail("p->pOrderBy==0", "sqlite3.c", 0x21044u, "int multiSelect(Parse *, Select *, SelectDest *)");
        iParm = v22;
        v23 = sqlite3VdbeAddOp2(v11, 112, v22, 0);
        if ( p->addrOpenEphm[0] != -1 )
          __assert_fail(
            "p->addrOpenEphm[0] == -1",
            "sqlite3.c",
            0x21047u,
            "int multiSelect(Parse *, Select *, SelectDest *)");
        v64 = db;
        p->addrOpenEphm[0] = v23;
        v24 = findRightmost(p);
        LOBYTE(v24->selFlags) |= 0x20u;
        if ( !p->pEList )
          __assert_fail("p->pEList", "sqlite3.c", 0x2104Au, "int multiSelect(Parse *, Select *, SelectDest *)");
        sqlite3SelectDestInit(&v82, 1, iParm);
        v25 = sqlite3Select(pParse, pPrior, &v82);
        if ( v25 )
        {
LABEL_53:
          v15 = v25;
          v14 = 0LL;
          db = v64;
          goto multi_select_end;
        }
        v26 = sqlite3VdbeAddOp2(v11, 112, iParm + 1, 0);
        if ( p->addrOpenEphm[1] != -1 )
          __assert_fail(
            "p->addrOpenEphm[1] == -1",
            "sqlite3.c",
            0x21058u,
            "int multiSelect(Parse *, Select *, SelectDest *)");
        p->addrOpenEphm[1] = v26;
        p->pPrior = 0LL;
        v27 = p->pLimit;
        p->pLimit = 0LL;
        v71 = iParm + 1;
        v82.iSDParm = iParm + 1;
        v28 = sqlite3SelectOpName(p->op);
        sqlite3VdbeExplain(pParse, 1u, "%s USING TEMP B-TREE", v28);
        v66 = sqlite3Select(pParse, p, &v82);
        v67 = p->pPrior;
        p->pPrior = pPrior;
        v29 = pPrior->nSelectRow;
        if ( p->nSelectRow > v29 )
          p->nSelectRow = v29;
        sqlite3ExprDelete(v64, p->pLimit);
        p->pLimit = v27;
        db = v64;
        v14 = v67;
        if ( !v66 )
        {
          v76 = v5;
          if ( !p->pEList )
            __assert_fail("p->pEList", "sqlite3.c", 0x2106Fu, "int multiSelect(Parse *, Select *, SelectDest *)");
          v30 = sqlite3VdbeMakeLabel(pParse);
          *(_QWORD *)x = v30;
          LODWORD(v31) = sqlite3VdbeMakeLabel(pParse);
          *(_QWORD *)p2 = v31;
          computeLimitRegisters(pParse, p, v30);
          sqlite3VdbeAddOp2(v11, 37, iParm, v30);
          TempReg = sqlite3GetTempReg(pParse);
          v78 = sqlite3VdbeAddOp2(v11, 130, iParm, TempReg);
          v33 = p2[0];
          sqlite3VdbeAddOp4Int(v11, 29, v71, p2[0], TempReg, 0);
          sqlite3ReleaseTempReg(pParse, TempReg);
          v34 = x[0];
          selectInnerLoop(pParse, p, iParm, 0LL, 0LL, &p1, v33, x[0]);
          sqlite3VdbeResolveLabel(v11, v33);
          sqlite3VdbeAddOp2(v11, 5, iParm, v78);
          sqlite3VdbeResolveLabel(v11, v34);
          sqlite3VdbeAddOp2(v11, 118, v71, 0);
          sqlite3VdbeAddOp2(v11, 118, iParm, 0);
          v5 = v76;
          db = v64;
          v14 = v67;
        }
        v6 = pParse;
        if ( p->pNext )
          goto LABEL_21;
LABEL_79:
        sqlite3VdbeExplainPop(v6);
        if ( (v3->selFlags & 0x20) != 0 )
          goto LABEL_80;
        goto LABEL_22;
      default:
        __assert_fail("p->op==TK_INTERSECT", "sqlite3.c", 0x21036u, "int multiSelect(Parse *, Select *, SelectDest *)");
    }
  }
  return multiSelectOrderBy(pParse, p, v5);
}
