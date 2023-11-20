int __fastcall selectExpander(Walker *pWalker, Select *p)
{
  Parse *pParse;
  sqlite3 *db;
  u32 selFlags;
  int result;
  Select *v6;
  u32 v7;
  With *pWith;
  _BYTE *v9;
  int i;
  __int64 v11;
  int v12;
  Select *v13;
  Table *TableItem;
  Table *v15;
  unsigned int nTabRef;
  VTable *pVTable;
  Select *v18;
  i16 nCol;
  __int64 nExpr;
  ExprList_item *a;
  __int64 v22;
  Expr *pExpr;
  u8 op;
  Expr *pRight;
  Expr *pLeft;
  __int64 v27;
  ExprList *v28;
  Expr *v29;
  Expr *v30;
  u8 v31;
  const char *v32;
  int v33;
  SrcItem *v34;
  Table *pTab;
  Select *pSelect;
  int v37;
  __int64 v38;
  __int64 v39;
  __int64 v40;
  __int64 v41;
  char *v42;
  char *zName;
  Expr *v44;
  Expr *v45;
  Expr *v46;
  Expr *v47;
  Expr *v48;
  char *v49;
  ExprList *v50;
  __int64 v51;
  ExprList *v52;
  __int64 v53;
  Expr *v54;
  bool v55;
  ExprList *v56;
  __int64 v57;
  ExprList *v58;
  bool v59;
  bool v60;
  sqlite3 *v61;
  int v62;
  ExprList *pEList;
  u16 eCode_low;
  Table *v65;
  int N;
  SrcList *pList;
  ExprList *v68;
  char *zRight;
  Expr *v70;
  Parse *v71;
  Select *v72;
  SrcItem *v73;
  char *zToken;
  char *zTab;
  Select *v76;
  __int64 v77;
  __int64 v78;
  Token pName;

  pParse = pWalker->pParse;
  db = pWalker->pParse->db;
  selFlags = p->selFlags;
  p->selFlags = selFlags | 0x40;
  if ( db->mallocFailed )
    return 2;
  v6 = p;
  v61 = db;
  pList = p->pSrc;
  if ( !pList )
    __assert_fail("p->pSrc!=0", "sqlite3.c", 0x21A1Au, "int selectExpander(Walker *, Select *)");
  result = 1;
  if ( (selFlags & 0x40) != 0 )
    return result;
  if ( pWalker->eCode )
  {
    v7 = pParse->nSelect + 1;
    pParse->nSelect = v7;
    p->selId = v7;
  }
  pEList = p->pEList;
  pWith = p->pWith;
  if ( (selFlags & 0x200000) != 0 && pParse->pWith )
  {
    if ( !pWith )
    {
      pWith = (With *)sqlite3DbMallocZero(db, 0x40uLL);
      v6->pWith = pWith;
      if ( !pWith )
        return 2;
    }
    pWith->bView = 1;
  }
  sqlite3WithPush(pParse, pWith, 0);
  sqlite3SrcListAssignCursors(pParse, pList);
  v71 = pParse;
  v72 = v6;
  if ( pList->nSrc > 0 )
  {
    v9 = (char *)&pList->a[0].fg + 1;
    for ( i = 0; i < pList->nSrc; ++i )
    {
      v11 = *(_QWORD *)(v9 - 29);
      if ( (*v9 & 0x20) != 0 )
      {
        if ( !v11 )
          __assert_fail(
            "pFrom->fg.isRecursive==0 || pFrom->pTab!=0",
            "sqlite3.c",
            0x21A3Au,
            "int selectExpander(Walker *, Select *)");
      }
      else if ( !v11 )
      {
        if ( *(_QWORD *)(v9 - 45) )
        {
          v12 = resolveFromTermToCte(pParse, pWalker, (SrcItem *)(v9 - 61));
          if ( v12 )
          {
            if ( v12 > 1 )
              return 2;
            if ( !*(_QWORD *)(v9 - 29) )
              __assert_fail("pTab!=0", "sqlite3.c", 0x21A4Au, "int selectExpander(Walker *, Select *)");
          }
          else
          {
            if ( *(_QWORD *)(v9 - 29) )
              __assert_fail("pFrom->pTab==0", "sqlite3.c", 0x21A4Eu, "int selectExpander(Walker *, Select *)");
            TableItem = sqlite3LocateTableItem(pParse, 0, (SrcItem *)(v9 - 61));
            *(_QWORD *)(v9 - 29) = TableItem;
            if ( !TableItem )
              return 2;
            v15 = TableItem;
            nTabRef = TableItem->nTabRef;
            if ( nTabRef >= 0xFFFF )
            {
              sqlite3ErrorMsg(pParse, "too many references to \"%s\": max 65535", v15->zName);
              *(_QWORD *)(v9 - 29) = 0LL;
              return 2;
            }
            v15->nTabRef = nTabRef + 1;
            if ( v15->nModuleArg )
              goto LABEL_35;
            if ( cannotBeFunction(pParse, (SrcItem *)(v9 - 61)) )
              return 2;
            if ( v15->nModuleArg || v15->pSelect )
            {
LABEL_35:
              eCode_low = LOBYTE(pWalker->eCode);
              if ( sqlite3ViewGetColumnNames(pParse, v15) )
                return 2;
              if ( *(_QWORD *)(v9 - 21) )
                __assert_fail("pFrom->pSelect==0", "sqlite3.c", 0x21A60u, "int selectExpander(Walker *, Select *)");
              if ( v15->pSelect && SLODWORD(v61->flags) >= 0 && v15->pSchema != v61->aDb[1].pSchema )
                sqlite3ErrorMsg(pParse, "access to view \"%s\" prohibited", v15->zName);
              if ( v15->nModuleArg && (*v9 & 0x40) != 0 )
              {
                pVTable = v15->pVTable;
                if ( !pVTable )
                  __assert_fail("0", "sqlite3.c", 0x21A6Cu, "int selectExpander(Walker *, Select *)");
                if ( ((LODWORD(v61->flags) >> 7) & 1) < pVTable->eVtabRisk )
                  sqlite3ErrorMsg(pParse, "unsafe use of virtual table \"%s\"", v15->zName);
              }
              v18 = sqlite3SelectDup(v61, v15->pSelect, 0);
              *(_QWORD *)(v9 - 21) = v18;
              nCol = v15->nCol;
              v15->nCol = -1;
              pWalker->eCode = 1;
              sqlite3WalkSelect(pWalker, v18);
              pWalker->eCode = eCode_low;
              v15->nCol = nCol;
              pParse = v71;
            }
          }
        }
        else
        {
          v13 = *(Select **)(v9 - 21);
          if ( !v13 )
            __assert_fail("pSel!=0", "sqlite3.c", 0x21A41u, "int selectExpander(Walker *, Select *)");
          if ( sqlite3WalkSelect(pWalker, v13) || sqlite3ExpandSubquery(pParse, (SrcItem *)(v9 - 61)) )
            return 2;
        }
        v6 = v72;
        if ( (*v9 & 2) != 0 && sqlite3IndexedByLookup(pParse, (SrcItem *)(v9 - 61)) )
          return 2;
      }
      v9 += 112;
    }
  }
  if ( v61->mallocFailed || sqliteProcessJoin(pParse, v6) )
    return 2;
  nExpr = pEList->nExpr;
  if ( nExpr <= 0 )
  {
    v62 = 0;
LABEL_126:
    v58 = v6->pEList;
    goto LABEL_127;
  }
  a = pEList->a;
  v22 = 0LL;
  v62 = 0;
  while ( 1 )
  {
    pExpr = a->pExpr;
    op = a->pExpr->op;
    if ( op != 0x8C )
    {
      if ( op == 0xB3 )
        break;
      goto LABEL_55;
    }
    pRight = pExpr->pRight;
    if ( !pRight )
      __assert_fail("pE->op!=TK_DOT || pE->pRight!=0", "sqlite3.c", 0x21A9Fu, "int selectExpander(Walker *, Select *)");
    pLeft = pExpr->pLeft;
    if ( !pLeft || pLeft->op != 59 )
      __assert_fail(
        "pE->op!=TK_DOT || (pE->pLeft!=0 && pE->pLeft->op==TK_ID)",
        "sqlite3.c",
        0x21AA0u,
        "int selectExpander(Walker *, Select *)");
    if ( pRight->op == 0xB3 )
      break;
LABEL_55:
    v62 |= pExpr->flags;
    ++v22;
    ++a;
    if ( v22 >= nExpr )
      goto LABEL_126;
  }
  v77 = pParse->db->flags & 0x44;
  v27 = 0LL;
  v68 = 0LL;
  v28 = pEList;
  while ( 2 )
  {
    v29 = v28->a[v27].pExpr;
    v62 |= v29->flags;
    v30 = v29->pRight;
    v31 = v29->op;
    if ( !v30 && v31 == 0x8C )
      __assert_fail("pE->op!=TK_DOT || pRight!=0", "sqlite3.c", 0x21AB4u, "int selectExpander(Walker *, Select *)");
    if ( v31 == 0xB3 )
    {
      v32 = 0LL;
      goto LABEL_70;
    }
    if ( v31 != 0x8C || v30->op != 0xB3 )
    {
      v56 = sqlite3ExprListAppend(pParse, v68, v29);
      v28 = pEList;
      if ( v56 )
      {
        v57 = 3LL * v56->nExpr;
        *((_QWORD *)v56 + v57 - 1) = pEList->a[v27].zEName;
        v28 = pEList;
        *((_BYTE *)&v56->nExpr + 8 * v57 + 1) = *((_BYTE *)&pEList->a[v27] + 17) & 3 | *((_BYTE *)&v56->nExpr
                                                                                       + 8 * v57
                                                                                       + 1) & 0xFC;
        pEList->a[v27].zEName = 0LL;
      }
      v68 = v56;
      pEList->a[v27].pExpr = 0LL;
      goto LABEL_65;
    }
    v54 = v29->pLeft;
    if ( !v54 )
      __assert_fail("pE->pLeft!=0", "sqlite3.c", 0x21AC7u, "int selectExpander(Walker *, Select *)");
    if ( (v54->flags & 0x400) != 0 )
      __assert_fail(
        "!ExprHasProperty(pE->pLeft, EP_IntValue)",
        "sqlite3.c",
        0x21AC8u,
        "int selectExpander(Walker *, Select *)");
    v32 = v54->u.zToken;
LABEL_70:
    if ( pList->nSrc <= 0 )
    {
      v6 = v72;
      if ( !v32 )
        goto LABEL_120;
      goto LABEL_63;
    }
    v78 = v27;
    N = 0;
    v33 = 0;
    v34 = pList->a;
    zTab = (char *)v32;
    do
    {
      pTab = v34->pTab;
      pSelect = v34->pSelect;
      zRight = v34->zAlias;
      if ( !zRight )
        zRight = pTab->zName;
      if ( v61->mallocFailed )
        break;
      v65 = v34->pTab;
      v73 = v34;
      if ( pSelect && (pSelect->selFlags & 0x800) != 0 )
      {
        v38 = 0LL;
        if ( pTab->nCol > 0 )
          goto LABEL_86;
      }
      else if ( !v32 || !sqlite3StrICmp(v32, zRight) )
      {
        v37 = sqlite3SchemaToIndex(v61, pTab->pSchema);
        v38 = v37 < 0 ? 5116137LL : (__int64)v61->aDb[v37].zDbSName;
        pSelect = 0LL;
        if ( pTab->nCol > 0 )
        {
LABEL_86:
          zToken = (char *)v38;
          v76 = pSelect;
          v60 = v32 != 0LL && pSelect != 0LL;
          v59 = v32 == 0LL && N != 0;
          v39 = 8LL;
          v40 = 0LL;
          v41 = 0LL;
          while ( 2 )
          {
            zName = pTab->aCol[v40].zName;
            if ( !zName )
              __assert_fail("zName", "sqlite3.c", 0x21AE3u, "int selectExpander(Walker *, Select *)");
            if ( v60 )
            {
              pTab = v65;
              if ( !sqlite3MatchEName((const ExprList_item *)((char *)v76->pEList + v39), 0LL, zTab, 0LL) )
                goto LABEL_91;
            }
            if ( (v72->selFlags & 0x20000) == 0 && (pTab->aCol[v40].colFlags & 2) != 0 )
              goto LABEL_91;
            if ( !v59
              || ((v73->fg.jointype & 4) == 0 || (v33 = 1, !tableAndColumnIndex(pList, N, zName, 0LL, 0LL, 1)))
              && (v33 = 1, sqlite3IdListIndex(v73->pUsing, zName) < 0) )
            {
              v44 = sqlite3Expr(v61, 59, zName);
              if ( v77 != 4 && pList->nSrc < 2 )
                goto LABEL_107;
              v45 = sqlite3Expr(v61, 59, zRight);
              v46 = sqlite3PExpr(pParse, 140, v45, v44);
              v47 = v46;
              if ( zToken )
              {
                v48 = sqlite3Expr(v61, 59, zToken);
                v44 = sqlite3PExpr(v71, 140, v48, v47);
                if ( v77 == 4 )
                  goto LABEL_105;
LABEL_107:
                v49 = 0LL;
              }
              else
              {
                v44 = v46;
                if ( v77 != 4 )
                  goto LABEL_107;
LABEL_105:
                v49 = sqlite3MPrintf(v61, "%s.%s", zRight, zName);
                zName = v49;
              }
              v70 = (Expr *)v49;
              v50 = sqlite3ExprListAppend(v71, v68, v44);
              sqlite3TokenInit(&pName, zName);
              sqlite3ExprListSetName(v71, v50, &pName, 0);
              v68 = v50;
              if ( v50 && (v72->selFlags & 0x800) != 0 && v71->eParseMode <= 1u )
              {
                v51 = v50->nExpr - 1LL;
                v52 = v50;
                v53 = v51;
                sqlite3DbFree(v61, v52->a[v51].zEName);
                if ( v76 )
                  v42 = sqlite3DbStrDup(v61, *(const char **)((char *)&v76->pEList->a[0].pExpr + v39));
                else
                  v42 = sqlite3MPrintf(v61, "%s.%s.%s", zToken, zRight, zName);
                v68->a[v53].zEName = v42;
                *((_BYTE *)&v68->a[v53] + 17) = *((_BYTE *)&v68->a[v53] + 17) & 0xFC | 2;
              }
              sqlite3DbFree(v61, v70);
              v33 = 1;
              pParse = v71;
            }
            pTab = v65;
LABEL_91:
            ++v41;
            ++v40;
            v39 += 24LL;
            if ( v41 >= pTab->nCol )
              break;
            continue;
          }
        }
      }
      v34 = v73 + 1;
      ++N;
      v32 = zTab;
    }
    while ( N < pList->nSrc );
    v55 = v33 == 0;
    v6 = v72;
    v28 = pEList;
    v27 = v78;
    if ( !v55 )
      goto LABEL_65;
    if ( v32 )
    {
LABEL_63:
      sqlite3ErrorMsg(pParse, "no such table: %s", v32);
      goto LABEL_64;
    }
LABEL_120:
    sqlite3ErrorMsg(pParse, "no tables specified");
LABEL_64:
    v28 = pEList;
LABEL_65:
    if ( ++v27 < v28->nExpr )
      continue;
    break;
  }
  sqlite3ExprListDelete(v61, v28);
  v58 = v68;
  v6->pEList = v68;
LABEL_127:
  result = 0;
  if ( v58 )
  {
    if ( v58->nExpr > v61->aLimit[2] )
    {
      sqlite3ErrorMsg(pParse, "too many columns in result set");
      return 2;
    }
    if ( (v62 & 0x200004) != 0 )
      BYTE2(v6->selFlags) |= 4u;
  }
  return result;
}
