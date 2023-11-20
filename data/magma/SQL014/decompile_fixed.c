int __fastcall multiSelect(Parse *pParse, Select *p, SelectDest *pDest)
{
  Select *v3;
  Select *pPrior;
  SelectDest *v5;
  Parse *v6;
  u32 selFlags;
  sqlite3 *db;
  __int128 v9;
  ExprList *pEList;
  int v11;
  int v12;
  Select *v13;
  ExprList *v14;
  ExprList *v15;
  int nExpr;
  KeyInfo *v17;
  KeyInfo *v18;
  SelectDest *v19;
  __int64 v20;
  CollSeq *v21;
  int iSDParm;
  int iLimit;
  int v24;
  int iOffset;
  int v26;
  int v27;
  Select *v28;
  int v29;
  const char *v30;
  LogEst v31;
  unsigned int v32;
  int TempReg;
  int v34;
  int nTab;
  int v36;
  Select *Rightmost;
  int v38;
  int op;
  u8 v40;
  int v41;
  KeyInfo *v42;
  int v43;
  KeyInfo *v44;
  Expr *pLimit;
  const char *v46;
  int Label;
  int v48;
  Select *v49;
  Expr *v50;
  int v51;
  LogEst nSelectRow;
  LogEst v53;
  bool v54;
  int v56;
  int v57;
  int v58;
  sqlite3 *v59;
  sqlite3 *v60;
  sqlite3 *v61;
  Vdbe *Vdbe;
  Select *v63;
  Select *v64;
  Select *v65;
  Expr *p2;
  int p2a;
  int p2b;
  Parse *v69;
  int iParm;
  int iParma;
  int v72;
  int v73;
  SelectDest p1;
  int x[2];
  SelectDest v76;

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
  if ( p1.eDest == 12 )
  {
    pEList = p->pEList;
    if ( !pEList )
      __assert_fail("p->pEList", "sqlite3.c", 0x20F87u, "int multiSelect(Parse *, Select *, SelectDest *)");
    sqlite3VdbeAddOp2(Vdbe, 112, p1.iSDParm, pEList->nExpr);
    p1.eDest = 14;
  }
  if ( (p->selFlags & 0x400) != 0 )
  {
    v11 = multiSelectValues(pParse, p, &p1);
    if ( v11 >= 0 )
    {
LABEL_14:
      v12 = v11;
      v13 = 0LL;
multi_select_end:
      v5->iSdst = p1.iSdst;
      v5->nSdst = p1.nSdst;
      sqlite3SelectDelete(db, v13);
      return v12;
    }
  }
  v14 = p->pEList;
  if ( !v14 || (v15 = pPrior->pEList) == 0LL )
    __assert_fail(
      "p->pEList && pPrior->pEList",
      "sqlite3.c",
      0x20F97u,
      "int multiSelect(Parse *, Select *, SelectDest *)");
  if ( v14->nExpr != v15->nExpr )
    __assert_fail(
      "p->pEList->nExpr==pPrior->pEList->nExpr",
      "sqlite3.c",
      0x20F98u,
      "int multiSelect(Parse *, Select *, SelectDest *)");
  if ( (p->selFlags & 0x2000) != 0 && hasAnchor(p) )
  {
    generateWithRecursiveQuery(pParse, p, &p1);
    v13 = 0LL;
    v12 = 0;
    if ( pParse->nErr )
      goto multi_select_end;
LABEL_21:
    if ( (v3->selFlags & 0x20) != 0 )
    {
      v63 = v13;
      if ( v3->pNext )
        __assert_fail("p->pNext==0", "sqlite3.c", 0x210A0u, "int multiSelect(Parse *, Select *, SelectDest *)");
      nExpr = v3->pEList->nExpr;
      v59 = db;
      v17 = sqlite3KeyInfoAlloc(db, nExpr, 1);
      if ( v17 )
      {
        v18 = v17;
        v56 = v12;
        v19 = v5;
        if ( nExpr > 0 )
        {
          v20 = 0LL;
          do
          {
            v21 = multiSelectCollSeq(v6, v3, v20);
            v18->aColl[v20] = v21;
            if ( !v21 )
              v18->aColl[v20] = v59->pDfltColl;
            ++v20;
          }
          while ( nExpr != (_DWORD)v20 );
        }
        v5 = v19;
        do
        {
          v41 = v3->addrOpenEphm[0];
          if ( v41 < 0 )
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
            sqlite3VdbeChangeP2(Vdbe, v41, nExpr);
            v42 = sqlite3KeyInfoRef(v18);
            sqlite3VdbeChangeP4(Vdbe, v41, (const char *)v42, -9);
            v3->addrOpenEphm[0] = -1;
            v43 = v3->addrOpenEphm[1];
            if ( v43 >= 0 )
            {
              sqlite3VdbeChangeP2(Vdbe, v43, nExpr);
              v44 = sqlite3KeyInfoRef(v18);
              sqlite3VdbeChangeP4(Vdbe, v43, (const char *)v44, -9);
              v3->addrOpenEphm[1] = -1;
            }
          }
          v3 = v3->pPrior;
        }
        while ( v3 );
        sqlite3KeyInfoUnref(v18);
        db = v59;
        v12 = v56;
      }
      else
      {
        v12 = sqlite3NomemError(135332);
      }
      v13 = v63;
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
        v60 = db;
        if ( p1.eDest == 1 )
        {
          if ( p->pLimit )
            __assert_fail("p->pLimit==0", "sqlite3.c", 0x20FEAu, "int multiSelect(Parse *, Select *, SelectDest *)");
          iSDParm = p1.iSDParm;
          if ( pPrior->pOrderBy )
            goto LABEL_110;
        }
        else
        {
          nTab = pParse->nTab;
          pParse->nTab = nTab + 1;
          if ( p->pOrderBy )
            __assert_fail("p->pOrderBy==0", "sqlite3.c", 0x20FF1u, "int multiSelect(Parse *, Select *, SelectDest *)");
          iSDParm = nTab;
          v36 = sqlite3VdbeAddOp2(Vdbe, 112, nTab, 0);
          if ( p->addrOpenEphm[0] != -1 )
            __assert_fail(
              "p->addrOpenEphm[0] == -1",
              "sqlite3.c",
              0x20FF3u,
              "int multiSelect(Parse *, Select *, SelectDest *)");
          p->addrOpenEphm[0] = v36;
          Rightmost = findRightmost(p);
          LOBYTE(Rightmost->selFlags) |= 0x20u;
          if ( !p->pEList )
            __assert_fail("p->pEList", "sqlite3.c", 0x20FF6u, "int multiSelect(Parse *, Select *, SelectDest *)");
          if ( pPrior->pOrderBy )
LABEL_110:
            __assert_fail(
              "!pPrior->pOrderBy",
              "sqlite3.c",
              0x20FFCu,
              "int multiSelect(Parse *, Select *, SelectDest *)");
        }
        sqlite3SelectDestInit(&v76, 1, iSDParm);
        v38 = sqlite3Select(pParse, pPrior, &v76);
        if ( v38 )
        {
          v12 = v38;
          v13 = 0LL;
          db = v60;
          goto multi_select_end;
        }
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
        v76.eDest = v40;
        v46 = sqlite3SelectOpName(op);
        sqlite3VdbeExplain(v6, 1u, "%s USING TEMP B-TREE", v46);
        v58 = sqlite3Select(v6, p, &v76);
        if ( p->pOrderBy )
          __assert_fail("p->pOrderBy==0", "sqlite3.c", 0x21015u, "int multiSelect(Parse *, Select *, SelectDest *)");
        v65 = p->pPrior;
        p->pPrior = pPrior;
        p->pOrderBy = 0LL;
        if ( p->op == 0x85 )
          p->nSelectRow = sqlite3LogEstAdd(p->nSelectRow, pPrior->nSelectRow);
        v69 = v6;
        sqlite3ExprDelete(v60, p->pLimit);
        p->pLimit = pLimit;
        *(_QWORD *)&p->iLimit = 0LL;
        if ( iSDParm != p1.iSDParm && p1.eDest == 1 )
          __assert_fail(
            "unionTab==dest.iSDParm || dest.eDest!=priorOp",
            "sqlite3.c",
            0x21024u,
            "int multiSelect(Parse *, Select *, SelectDest *)");
        v12 = v58;
        v13 = v65;
        if ( !p->pEList && !v60->mallocFailed )
          __assert_fail(
            "p->pEList || db->mallocFailed",
            "sqlite3.c",
            0x21025u,
            "int multiSelect(Parse *, Select *, SelectDest *)");
        if ( p1.eDest != 1 && !v60->mallocFailed )
        {
          Label = sqlite3VdbeMakeLabel(v6);
          iParma = sqlite3VdbeMakeLabel(v6);
          computeLimitRegisters(v6, p, Label);
          sqlite3VdbeAddOp2(Vdbe, 37, iSDParm, Label);
          p2b = sqlite3VdbeCurrentAddr(Vdbe);
          selectInnerLoop(v6, p, iSDParm, 0LL, 0LL, &p1, iParma, Label);
          sqlite3VdbeResolveLabel(Vdbe, iParma);
          sqlite3VdbeAddOp2(Vdbe, 5, iSDParm, p2b);
          v48 = Label;
          v12 = v58;
          sqlite3VdbeResolveLabel(Vdbe, v48);
          v13 = v65;
          sqlite3VdbeAddOp2(Vdbe, 118, iSDParm, 0);
        }
        db = v60;
LABEL_84:
        if ( v3->pNext )
        {
LABEL_85:
          v6 = v69;
          if ( v69->nErr )
            goto multi_select_end;
        }
        else
        {
LABEL_96:
          v6 = v69;
          sqlite3VdbeExplainPop(v69);
          if ( v69->nErr )
            goto multi_select_end;
        }
        goto LABEL_21;
      case 0x86:
        *(_DWORD *)&v76.eDest = 0;
        if ( pPrior->pLimit )
          __assert_fail("!pPrior->pLimit", "sqlite3.c", 0x20FB3u, "int multiSelect(Parse *, Select *, SelectDest *)");
        pPrior->iLimit = p->iLimit;
        pPrior->iOffset = p->iOffset;
        pPrior->pLimit = p->pLimit;
        v11 = sqlite3Select(pParse, pPrior, &p1);
        pPrior->pLimit = 0LL;
        if ( v11 )
          goto LABEL_14;
        v61 = db;
        p->pPrior = 0LL;
        iLimit = pPrior->iLimit;
        p->iLimit = iLimit;
        p->iOffset = pPrior->iOffset;
        if ( iLimit )
        {
          v24 = sqlite3VdbeAddOp1(Vdbe, 20, iLimit);
          sqlite3VdbeComment(Vdbe, "Jump ahead if LIMIT reached");
          iOffset = p->iOffset;
          if ( iOffset )
            sqlite3VdbeAddOp3(Vdbe, 156, p->iLimit, iOffset + 1, iOffset);
        }
        else
        {
          v24 = 0;
        }
        sqlite3VdbeExplain(pParse, 1u, "UNION ALL");
        v69 = pParse;
        v12 = sqlite3Select(pParse, p, &p1);
        v49 = p->pPrior;
        p->pPrior = pPrior;
        p->nSelectRow = sqlite3LogEstAdd(p->nSelectRow, pPrior->nSelectRow);
        v50 = p->pLimit;
        if ( v50 )
        {
          if ( sqlite3ExprIsInteger(v50->pLeft, (int *)&v76) )
          {
            if ( *(int *)&v76.eDest > 0 )
            {
              v51 = v12;
              nSelectRow = p->nSelectRow;
              v53 = sqlite3LogEst(*(int *)&v76.eDest);
              v54 = nSelectRow <= v53;
              v12 = v51;
              if ( !v54 )
                p->nSelectRow = v53;
            }
          }
        }
        if ( v24 )
          sqlite3VdbeJumpHere(Vdbe, v24);
        db = v61;
        v13 = v49;
        if ( !p->pNext )
          goto LABEL_96;
        goto LABEL_85;
      case 0x88:
        v26 = pParse->nTab;
        pParse->nTab = v26 + 2;
        if ( p->pOrderBy )
          __assert_fail("p->pOrderBy==0", "sqlite3.c", 0x21044u, "int multiSelect(Parse *, Select *, SelectDest *)");
        iParm = v26;
        v27 = sqlite3VdbeAddOp2(Vdbe, 112, v26, 0);
        if ( p->addrOpenEphm[0] != -1 )
          __assert_fail(
            "p->addrOpenEphm[0] == -1",
            "sqlite3.c",
            0x21047u,
            "int multiSelect(Parse *, Select *, SelectDest *)");
        p->addrOpenEphm[0] = v27;
        v28 = findRightmost(p);
        LOBYTE(v28->selFlags) |= 0x20u;
        if ( !p->pEList )
          __assert_fail("p->pEList", "sqlite3.c", 0x2104Au, "int multiSelect(Parse *, Select *, SelectDest *)");
        sqlite3SelectDestInit(&v76, 1, iParm);
        v11 = sqlite3Select(pParse, pPrior, &v76);
        if ( v11 )
          goto LABEL_14;
        v29 = sqlite3VdbeAddOp2(Vdbe, 112, iParm + 1, 0);
        if ( p->addrOpenEphm[1] != -1 )
          __assert_fail(
            "p->addrOpenEphm[1] == -1",
            "sqlite3.c",
            0x21058u,
            "int multiSelect(Parse *, Select *, SelectDest *)");
        p->addrOpenEphm[1] = v29;
        p->pPrior = 0LL;
        p2 = p->pLimit;
        p->pLimit = 0LL;
        v72 = iParm + 1;
        v76.iSDParm = iParm + 1;
        v30 = sqlite3SelectOpName(p->op);
        sqlite3VdbeExplain(pParse, 1u, "%s USING TEMP B-TREE", v30);
        v69 = pParse;
        v57 = sqlite3Select(pParse, p, &v76);
        v64 = p->pPrior;
        p->pPrior = pPrior;
        v31 = pPrior->nSelectRow;
        if ( p->nSelectRow > v31 )
          p->nSelectRow = v31;
        sqlite3ExprDelete(db, p->pLimit);
        p->pLimit = p2;
        v12 = v57;
        v13 = v64;
        if ( v57 )
          goto LABEL_84;
        if ( !p->pEList )
          __assert_fail("p->pEList", "sqlite3.c", 0x2106Fu, "int multiSelect(Parse *, Select *, SelectDest *)");
        v32 = sqlite3VdbeMakeLabel(pParse);
        *(_QWORD *)x = v32;
        p2a = sqlite3VdbeMakeLabel(pParse);
        computeLimitRegisters(pParse, p, v32);
        sqlite3VdbeAddOp2(Vdbe, 37, iParm, v32);
        TempReg = sqlite3GetTempReg(pParse);
        v73 = sqlite3VdbeAddOp2(Vdbe, 130, iParm, TempReg);
        sqlite3VdbeAddOp4Int(Vdbe, 29, v72, p2a, TempReg, 0);
        sqlite3ReleaseTempReg(pParse, TempReg);
        v34 = x[0];
        selectInnerLoop(pParse, p, iParm, 0LL, 0LL, &p1, p2a, x[0]);
        sqlite3VdbeResolveLabel(Vdbe, p2a);
        sqlite3VdbeAddOp2(Vdbe, 5, iParm, v73);
        sqlite3VdbeResolveLabel(Vdbe, v34);
        sqlite3VdbeAddOp2(Vdbe, 118, v72, 0);
        sqlite3VdbeAddOp2(Vdbe, 118, iParm, 0);
        v12 = 0;
        v13 = v64;
        if ( !p->pNext )
          goto LABEL_96;
        goto LABEL_85;
      default:
        __assert_fail("p->op==TK_INTERSECT", "sqlite3.c", 0x21036u, "int multiSelect(Parse *, Select *, SelectDest *)");
    }
  }
  return multiSelectOrderBy(pParse, p, v5);
}
