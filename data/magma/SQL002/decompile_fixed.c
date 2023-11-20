int __fastcall selectExpander(Walker *pWalker, Select *p)
{
  Parse *pParse;
  sqlite3 *db;
  u32 selFlags;
  int result;
  u32 v8;
  With *pWith;
  Select *v10;
  _BYTE *v11;
  int i;
  __int64 v13;
  int v14;
  Select *v15;
  Table *TableItem;
  Table *v17;
  unsigned int nTabRef;
  u16 eCode_low;
  VTable *pVTable;
  Select *v21;
  i16 nCol;
  Parse *v23;
  Select *v24;
  __int64 nExpr;
  ExprList_item *a;
  __int64 v27;
  Expr *pExpr;
  u8 op;
  Expr *pRight;
  Expr *pLeft;
  __int64 v32;
  ExprList *v33;
  __int64 v34;
  SrcItem *v35;
  char *zAlias;
  char pSchema;
  const char *v38;
  int v39;
  Table *pTab;
  Select *pSelect;
  int v42;
  __int64 v43;
  __int64 v44;
  __int64 v45;
  __int64 v46;
  char *v47;
  char *v48;
  Expr *v49;
  Expr *v50;
  Expr *v51;
  Expr *v52;
  Expr *v53;
  Expr *v54;
  ExprList *v55;
  Expr *v56;
  char *v57;
  ExprList *v58;
  bool v59;
  __int64 v60;
  __int64 v61;
  char *zName;
  ExprList *v63;
  __int64 v64;
  ExprList *v65;
  Parse *v66;
  bool v67;
  bool v68;
  sqlite3 *v69;
  int v70;
  ExprList *v71;
  u16 v72;
  Table *v73;
  int N;
  SrcList *pList;
  char *zRight;
  ExprList *pEList;
  Select *v78;
  SrcItem *v79;
  char *v80;
  char *zToken;
  char *zTab;
  Select *v83;
  __int64 v84;
  __int64 v85;
  Token pName;

  pParse = pWalker->pParse;
  db = pWalker->pParse->db;
  selFlags = p->selFlags;
  p->selFlags = selFlags | 0x40;
  if ( db->mallocFailed )
    return 2;
  pList = p->pSrc;
  if ( !pList )
    __assert_fail("p->pSrc!=0", "sqlite3.c", 0x21A1Au, "int selectExpander(Walker *, Select *)");
  result = 1;
  if ( (selFlags & 0x40) == 0 )
  {
    if ( pWalker->eCode )
    {
      v8 = pParse->nSelect + 1;
      pParse->nSelect = v8;
      p->selId = v8;
    }
    pEList = p->pEList;
    pWith = p->pWith;
    v69 = db;
    if ( (selFlags & 0x200000) != 0 && pParse->pWith )
    {
      if ( !pWith )
      {
        pWith = (With *)sqlite3DbMallocZero(db, 0x40uLL);
        p->pWith = pWith;
        if ( !pWith )
          return 2;
      }
      pWith->bView = 1;
    }
    sqlite3WithPush(pParse, pWith, 0);
    v66 = pParse;
    sqlite3SrcListAssignCursors(pParse, pList);
    v10 = p;
    v78 = p;
    if ( pList->nSrc > 0 )
    {
      v11 = (char *)&pList->a[0].fg + 1;
      for ( i = 0; i < pList->nSrc; ++i )
      {
        v13 = *(_QWORD *)(v11 - 29);
        if ( (*v11 & 0x20) != 0 )
        {
          if ( !v13 )
            __assert_fail(
              "pFrom->fg.isRecursive==0 || pFrom->pTab!=0",
              "sqlite3.c",
              0x21A3Au,
              "int selectExpander(Walker *, Select *)");
        }
        else if ( !v13 )
        {
          if ( *(_QWORD *)(v11 - 45) )
          {
            v14 = resolveFromTermToCte(v66, pWalker, (SrcItem *)(v11 - 61));
            if ( v14 )
            {
              if ( v14 > 1 )
                return 2;
              if ( !*(_QWORD *)(v11 - 29) )
                __assert_fail("pTab!=0", "sqlite3.c", 0x21A4Au, "int selectExpander(Walker *, Select *)");
            }
            else
            {
              if ( *(_QWORD *)(v11 - 29) )
                __assert_fail("pFrom->pTab==0", "sqlite3.c", 0x21A4Eu, "int selectExpander(Walker *, Select *)");
              TableItem = sqlite3LocateTableItem(v66, 0, (SrcItem *)(v11 - 61));
              *(_QWORD *)(v11 - 29) = TableItem;
              if ( !TableItem )
                return 2;
              v17 = TableItem;
              nTabRef = TableItem->nTabRef;
              if ( nTabRef >= 0xFFFF )
              {
                sqlite3ErrorMsg(v66, "too many references to \"%s\": max 65535", v17->zName);
                *(_QWORD *)(v11 - 29) = 0LL;
                return 2;
              }
              v17->nTabRef = nTabRef + 1;
              if ( v17->nModuleArg )
                goto LABEL_35;
              if ( cannotBeFunction(v66, (SrcItem *)(v11 - 61)) )
                return 2;
              if ( v17->nModuleArg || v17->pSelect )
              {
LABEL_35:
                eCode_low = LOBYTE(pWalker->eCode);
                if ( sqlite3ViewGetColumnNames(v66, v17) )
                  return 2;
                if ( *(_QWORD *)(v11 - 21) )
                  __assert_fail("pFrom->pSelect==0", "sqlite3.c", 0x21A60u, "int selectExpander(Walker *, Select *)");
                if ( v17->pSelect && SLODWORD(db->flags) >= 0 && v17->pSchema != db->aDb[1].pSchema )
                  sqlite3ErrorMsg(v66, "access to view \"%s\" prohibited", v17->zName);
                v72 = eCode_low;
                if ( v17->nModuleArg && (*v11 & 0x40) != 0 )
                {
                  pVTable = v17->pVTable;
                  if ( !pVTable )
                    __assert_fail("0", "sqlite3.c", 0x21A6Cu, "int selectExpander(Walker *, Select *)");
                  if ( ((LODWORD(db->flags) >> 7) & 1) < pVTable->eVtabRisk )
                    sqlite3ErrorMsg(v66, "unsafe use of virtual table \"%s\"", v17->zName);
                }
                v21 = sqlite3SelectDup(db, v17->pSelect, 0);
                *(_QWORD *)(v11 - 21) = v21;
                nCol = v17->nCol;
                v17->nCol = -1;
                pWalker->eCode = 1;
                sqlite3WalkSelect(pWalker, v21);
                pWalker->eCode = v72;
                v17->nCol = nCol;
                v10 = v78;
              }
            }
          }
          else
          {
            v15 = *(Select **)(v11 - 21);
            if ( !v15 )
              __assert_fail("pSel!=0", "sqlite3.c", 0x21A41u, "int selectExpander(Walker *, Select *)");
            if ( sqlite3WalkSelect(pWalker, v15) || sqlite3ExpandSubquery(v66, (SrcItem *)(v11 - 61)) )
              return 2;
          }
          if ( (*v11 & 2) != 0 && sqlite3IndexedByLookup(v66, (SrcItem *)(v11 - 61)) )
            return 2;
        }
        v11 += 112;
      }
    }
    v23 = v66;
    if ( v66->nErr )
      return 2;
    if ( db->mallocFailed )
      return 2;
    v24 = v10;
    if ( sqliteProcessJoin(v66, v10) )
      return 2;
    nExpr = pEList->nExpr;
    if ( nExpr > 0 )
    {
      a = pEList->a;
      v27 = 0LL;
      v70 = 0;
      while ( 1 )
      {
        pExpr = a->pExpr;
        op = a->pExpr->op;
        if ( op == 0x8C )
        {
          pRight = pExpr->pRight;
          if ( !pRight )
            __assert_fail(
              "pE->op!=TK_DOT || pE->pRight!=0",
              "sqlite3.c",
              0x21A9Fu,
              "int selectExpander(Walker *, Select *)");
          pLeft = pExpr->pLeft;
          if ( !pLeft || pLeft->op != 59 )
            __assert_fail(
              "pE->op!=TK_DOT || (pE->pLeft!=0 && pE->pLeft->op==TK_ID)",
              "sqlite3.c",
              0x21AA0u,
              "int selectExpander(Walker *, Select *)");
          v24 = v10;
          if ( pRight->op == 0xB3 )
          {
LABEL_62:
            v84 = v66->db->flags & 0x44;
            v71 = 0LL;
            v32 = 0LL;
            v33 = pEList;
            while ( 1 )
            {
              v85 = v32;
              v34 = v32;
              v35 = (SrcItem *)v33->a[v32].pExpr;
              v70 |= HIDWORD(v35->pSchema);
              zAlias = v35->zAlias;
              pSchema = (char)v35->pSchema;
              if ( !zAlias && pSchema == -116 )
                __assert_fail(
                  "pE->op!=TK_DOT || pRight!=0",
                  "sqlite3.c",
                  0x21AB4u,
                  "int selectExpander(Walker *, Select *)");
              if ( pSchema == -77 )
              {
                v38 = 0LL;
              }
              else
              {
                if ( pSchema != -116 || *zAlias != -77 )
                {
                  v63 = sqlite3ExprListAppend(v23, v71, (Expr *)v35);
                  if ( v63 )
                  {
                    v64 = 3LL * v63->nExpr;
                    *((_QWORD *)v63 + v64 - 1) = pEList->a[v34].zEName;
                    *((_BYTE *)&v63->nExpr + 8 * v64 + 1) = *((_BYTE *)&pEList->a[v34] + 17) & 3 | *((_BYTE *)&v63->nExpr + 8 * v64 + 1) & 0xFC;
                    pEList->a[v34].zEName = 0LL;
                  }
                  v71 = v63;
                  pEList->a[v34].pExpr = 0LL;
                  goto LABEL_64;
                }
                zName = v35->zName;
                if ( !zName )
                  __assert_fail("pE->pLeft!=0", "sqlite3.c", 0x21AC7u, "int selectExpander(Walker *, Select *)");
                if ( (zName[5] & 4) != 0 )
                  __assert_fail(
                    "!ExprHasProperty(pE->pLeft, EP_IntValue)",
                    "sqlite3.c",
                    0x21AC8u,
                    "int selectExpander(Walker *, Select *)");
                v38 = (const char *)*((_QWORD *)zName + 1);
              }
              if ( pList->nSrc > 0 )
                break;
              v23 = v66;
LABEL_125:
              if ( v38 )
                sqlite3ErrorMsg(v23, "no such table: %s", v38);
              else
                sqlite3ErrorMsg(v23, "no tables specified", v35);
LABEL_64:
              v33 = pEList;
              v32 = v85 + 1;
              if ( v85 + 1 >= pEList->nExpr )
              {
                sqlite3ExprListDelete(v69, pEList);
                v65 = v71;
                v24->pEList = v71;
                goto LABEL_131;
              }
            }
            N = 0;
            v39 = 0;
            v35 = pList->a;
            zTab = (char *)v38;
            while ( 2 )
            {
              pTab = v35->pTab;
              pSelect = v35->pSelect;
              zRight = v35->zAlias;
              if ( !zRight )
                zRight = pTab->zName;
              if ( v69->mallocFailed )
              {
LABEL_119:
                v59 = v39 == 0;
                v23 = v66;
                if ( v59 )
                  goto LABEL_125;
                goto LABEL_64;
              }
              v73 = v35->pTab;
              v79 = v35;
              if ( pSelect && (pSelect->selFlags & 0x800) != 0 )
              {
                v43 = 0LL;
                if ( pTab->nCol > 0 )
                {
LABEL_85:
                  zToken = (char *)v43;
                  v83 = pSelect;
                  v68 = v38 != 0LL && pSelect != 0LL;
                  v67 = v38 == 0LL && N != 0;
                  v44 = 8LL;
                  v45 = 0LL;
                  v46 = 0LL;
                  do
                  {
                    v48 = pTab->aCol[v45].zName;
                    if ( !v48 )
                      __assert_fail("zName", "sqlite3.c", 0x21AE3u, "int selectExpander(Walker *, Select *)");
                    if ( !v68
                      || (pTab = v73,
                          sqlite3MatchEName((const ExprList_item *)((char *)v83->pEList + v44), 0LL, zTab, 0LL)) )
                    {
                      if ( (v24->selFlags & 0x20000) != 0 || (pTab->aCol[v45].colFlags & 2) == 0 )
                      {
                        if ( !v67
                          || ((v79->fg.jointype & 4) == 0 || (v39 = 1, !tableAndColumnIndex(pList, N, v48, 0LL, 0LL, 1)))
                          && (v39 = 1, sqlite3IdListIndex(v79->pUsing, v48) < 0) )
                        {
                          v49 = sqlite3Expr(v69, 59, v48);
                          if ( v84 == 4 || pList->nSrc >= 2 )
                          {
                            v50 = v49;
                            v51 = sqlite3Expr(v69, 59, zRight);
                            v52 = sqlite3PExpr(v66, 140, v51, v50);
                            v49 = v52;
                            if ( zToken )
                            {
                              v53 = v52;
                              v54 = sqlite3Expr(v69, 59, zToken);
                              v49 = sqlite3PExpr(v66, 140, v54, v53);
                            }
                            v55 = v71;
                            if ( v84 == 4 )
                            {
                              v56 = v49;
                              v57 = sqlite3MPrintf(v69, "%s.%s", zRight, v48);
                              v49 = v56;
                              v48 = v57;
                            }
                            else
                            {
                              v57 = 0LL;
                            }
                            v80 = v57;
                          }
                          else
                          {
                            v80 = 0LL;
                            v55 = v71;
                          }
                          v58 = sqlite3ExprListAppend(v66, v55, v49);
                          sqlite3TokenInit(&pName, v48);
                          sqlite3ExprListSetName(v66, v58, &pName, 0);
                          v71 = v58;
                          v59 = v58 == 0LL;
                          v24 = v78;
                          if ( !v59 && (v78->selFlags & 0x800) != 0 && v66->eParseMode <= 1u )
                          {
                            v60 = v71->nExpr - 1LL;
                            v61 = v60;
                            sqlite3DbFree(v69, v71->a[v60].zEName);
                            if ( v83 )
                              v47 = sqlite3DbStrDup(v69, *(const char **)((char *)&v83->pEList->a[0].pExpr + v44));
                            else
                              v47 = sqlite3MPrintf(v69, "%s.%s.%s", zToken, zRight, v48);
                            v71->a[v61].zEName = v47;
                            *((_BYTE *)&v71->a[v61] + 17) = *((_BYTE *)&v71->a[v61] + 17) & 0xFC | 2;
                            v24 = v78;
                          }
                          sqlite3DbFree(v69, v80);
                          v39 = 1;
                        }
                        pTab = v73;
                      }
                    }
                    ++v46;
                    ++v45;
                    v44 += 24LL;
                  }
                  while ( v46 < pTab->nCol );
                }
              }
              else if ( !v38 || !sqlite3StrICmp(v38, zRight) )
              {
                v42 = sqlite3SchemaToIndex(v69, pTab->pSchema);
                v43 = v42 < 0 ? 5116599LL : (__int64)v69->aDb[v42].zDbSName;
                pSelect = 0LL;
                if ( pTab->nCol > 0 )
                  goto LABEL_85;
              }
              v35 = v79 + 1;
              ++N;
              v38 = zTab;
              if ( N >= pList->nSrc )
                goto LABEL_119;
              continue;
            }
          }
        }
        else if ( op == 0xB3 )
        {
          goto LABEL_62;
        }
        v70 |= pExpr->flags;
        ++v27;
        ++a;
        if ( v27 >= nExpr )
          goto LABEL_130;
      }
    }
    v70 = 0;
LABEL_130:
    v65 = v24->pEList;
LABEL_131:
    result = 0;
    if ( v65 )
    {
      if ( v65->nExpr > v69->aLimit[2] )
      {
        sqlite3ErrorMsg(v23, "too many columns in result set");
        return 2;
      }
      if ( (v70 & 0x200004) != 0 )
        BYTE2(v24->selFlags) |= 4u;
    }
  }
  return result;
}
