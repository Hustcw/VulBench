static char **tableColumnList(ShellState *p, const char *zTab) {
  char **azCol = 0;
  sqlite3_stmt *pStmt;
  char *zSql;
  int nCol = 0;
  int nAlloc = 0;
  int nPK = 0;   /* Number of PRIMARY KEY columns seen */
  int isIPK = 0; /* True if one PRIMARY KEY column of type INTEGER */
  int preserveRowid = ShellHasFlag(p, SHFLG_PreserveRowid);
  int rc;

  zSql = sqlite3_mprintf("PRAGMA table_info=%Q", zTab);
  rc = sqlite3_prepare_v2(p->db, zSql, -1, &pStmt, 0);
  sqlite3_free(zSql);
  if (rc)
    return 0;
  while (sqlite3_step(pStmt) == SQLITE_ROW) {
    if (nCol >= nAlloc - 2) {
      nAlloc = nAlloc * 2 + nCol + 10;
      azCol = sqlite3_realloc(azCol, nAlloc * sizeof(azCol[0]));
      if (azCol == 0)
        shell_out_of_memory();
    }
    azCol[++nCol] = sqlite3_mprintf("%s", sqlite3_column_text(pStmt, 1));
    if (sqlite3_column_int(pStmt, 5)) {
      nPK++;
      if (nPK == 1 &&
          sqlite3_stricmp((const char *)sqlite3_column_text(pStmt, 2),
                          "INTEGER") == 0) {
        isIPK = 1;
      } else {
        isIPK = 0;
      }
    }
  }
  sqlite3_finalize(pStmt);
  azCol[0] = 0;
  azCol[nCol + 1] = 0;

  /* The decision of whether or not a rowid really needs to be preserved
  ** is tricky.  We never need to preserve a rowid for a WITHOUT ROWID table
  ** or a table with an INTEGER PRIMARY KEY.  We are unable to preserve
  ** rowids on tables where the rowid is inaccessible because there are other
  ** columns in the table named "rowid", "_rowid_", and "oid".
  */
  if (preserveRowid && isIPK) {
    /* If a single PRIMARY KEY column with type INTEGER was seen, then it
    ** might be an alise for the ROWID.  But it might also be a WITHOUT ROWID
    ** table or a INTEGER PRIMARY KEY DESC column, neither of which are
    ** ROWID aliases.  To distinguish these cases, check to see if
    ** there is a "pk" entry in "PRAGMA index_list".  There will be
    ** no "pk" index if the PRIMARY KEY really is an alias for the ROWID.
    */
    zSql = sqlite3_mprintf("SELECT 1 FROM pragma_index_list(%Q)"
                           " WHERE origin='pk'",
                           zTab);
    rc = sqlite3_prepare_v2(p->db, zSql, -1, &pStmt, 0);
    sqlite3_free(zSql);
    if (rc) {
      freeColumnList(azCol);
      return 0;
    }
    rc = sqlite3_step(pStmt);
    sqlite3_finalize(pStmt);
    preserveRowid = rc == SQLITE_ROW;
  }
  if (preserveRowid) {
    /* Only preserve the rowid if we can find a name to use for the
    ** rowid */
    static char *azRowid[] = {"rowid", "_rowid_", "oid"};
    int i, j;
    for (j = 0; j < 3; j++) {
      for (i = 1; i <= nCol; i++) {
        if (sqlite3_stricmp(azRowid[j], azCol[i]) == 0)
          break;
      }
      if (i > nCol) {
        /* At this point, we know that azRowid[j] is not the name of any
        ** ordinary column in the table.  Verify that azRowid[j] is a valid
        ** name for the rowid before adding it to azCol[0].  WITHOUT ROWID
        ** tables will fail this last check */
        rc = sqlite3_table_column_metadata(p->db, 0, zTab, azRowid[j], 0, 0, 0,
                                           0, 0);
        if (rc == SQLITE_OK)
          azCol[0] = azRowid[j];
        break;
      }
    }
  }
  return azCol;
}

