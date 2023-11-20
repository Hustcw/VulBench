static int zipfileUpdate(sqlite3_vtab *pVtab, int nVal, sqlite3_value **apVal,
                         sqlite_int64 *pRowid) {
  ZipfileTab *pTab = (ZipfileTab *)pVtab;
  int rc = SQLITE_OK;     /* Return Code */
  ZipfileEntry *pNew = 0; /* New in-memory CDS entry */

  u32 mode = 0;          /* Mode for new entry */
  u32 mTime = 0;         /* Modification time for new entry */
  i64 sz = 0;            /* Uncompressed size */
  const char *zPath = 0; /* Path for new entry */
  int nPath = 0;         /* strlen(zPath) */
  const u8 *pData = 0;   /* Pointer to buffer containing content */
  int nData = 0;         /* Size of pData buffer in bytes */
  int iMethod = 0;       /* Compression method for new entry */
  u8 *pFree = 0;         /* Free this */
  char *zFree = 0;       /* Also free this */
  ZipfileEntry *pOld = 0;
  ZipfileEntry *pOld2 = 0;
  int bUpdate = 0; /* True for an update that modifies "name" */
  int bIsDir = 0;
  u32 iCrc32 = 0;

  if (pTab->pWriteFd == 0) {
    rc = zipfileBegin(pVtab);
    if (rc != SQLITE_OK)
      return rc;
  }

  /* If this is a DELETE or UPDATE, find the archive entry to delete. */
  if (sqlite3_value_type(apVal[0]) != SQLITE_NULL) {
    const char *zDelete = (const char *)sqlite3_value_text(apVal[0]);
    int nDelete = (int)strlen(zDelete);
    if (nVal > 1) {
      const char *zUpdate = (const char *)sqlite3_value_text(apVal[1]);
      if (zUpdate && zipfileComparePath(zUpdate, zDelete, nDelete) != 0) {
        bUpdate = 1;
      }
    }
    for (pOld = pTab->pFirstEntry; 1; pOld = pOld->pNext) {
      if (zipfileComparePath(pOld->cds.zFile, zDelete, nDelete) == 0) {
        break;
      }
      assert(pOld->pNext);
    }
  }

  if (nVal > 1) {
    /* Check that "sz" and "rawdata" are both NULL: */
    if (sqlite3_value_type(apVal[5]) != SQLITE_NULL) {
      zipfileTableErr(pTab, "sz must be NULL");
      rc = SQLITE_CONSTRAINT;
    }
    if (sqlite3_value_type(apVal[6]) != SQLITE_NULL) {
      zipfileTableErr(pTab, "rawdata must be NULL");
      rc = SQLITE_CONSTRAINT;
    }

    if (rc == SQLITE_OK) {
      if (sqlite3_value_type(apVal[7]) == SQLITE_NULL) {
        /* data=NULL. A directory */
        bIsDir = 1;
      } else {
        /* Value specified for "data", and possibly "method". This must be
        ** a regular file or a symlink. */
        const u8 *aIn = sqlite3_value_blob(apVal[7]);
        int nIn = sqlite3_value_bytes(apVal[7]);
        int bAuto = sqlite3_value_type(apVal[8]) == SQLITE_NULL;

        iMethod = sqlite3_value_int(apVal[8]);
        sz = nIn;
        pData = aIn;
        nData = nIn;
        if (iMethod != 0 && iMethod != 8) {
          zipfileTableErr(pTab, "unknown compression method: %d", iMethod);
          rc = SQLITE_CONSTRAINT;
        } else {
          if (bAuto || iMethod) {
            int nCmp;
            rc = zipfileDeflate(aIn, nIn, &pFree, &nCmp, &pTab->base.zErrMsg);
            if (rc == SQLITE_OK) {
              if (iMethod || nCmp < nIn) {
                iMethod = 8;
                pData = pFree;
                nData = nCmp;
              }
            }
          }
          iCrc32 = crc32(0, aIn, nIn);
        }
      }
    }

    if (rc == SQLITE_OK) {
      rc = zipfileGetMode(apVal[3], bIsDir, &mode, &pTab->base.zErrMsg);
    }

    if (rc == SQLITE_OK) {
      zPath = (const char *)sqlite3_value_text(apVal[2]);
      nPath = (int)strlen(zPath);
      mTime = zipfileGetTime(apVal[4]);
    }

    if (rc == SQLITE_OK && bIsDir) {
      /* For a directory, check that the last character in the path is a
      ** '/'. This appears to be required for compatibility with info-zip
      ** (the unzip command on unix). It does not create directories
      ** otherwise.  */
      if (nPath <= 0 || zPath[nPath - 1] != '/') {
        zFree = sqlite3_mprintf("%s/", zPath);
        zPath = (const char *)zFree;
        if (zFree == 0) {
          rc = SQLITE_NOMEM;
          nPath = 0;
        } else {
          nPath = (int)strlen(zPath);
        }
      }
    }

    /* Check that we're not inserting a duplicate entry -OR- updating an
    ** entry with a path, thereby making it into a duplicate. */
    if ((pOld == 0 || bUpdate) && rc == SQLITE_OK) {
      ZipfileEntry *p;
      for (p = pTab->pFirstEntry; p; p = p->pNext) {
        if (zipfileComparePath(p->cds.zFile, zPath, nPath) == 0) {
          switch (sqlite3_vtab_on_conflict(pTab->db)) {
          case SQLITE_IGNORE: {
            goto zipfile_update_done;
          }
          case SQLITE_REPLACE: {
            pOld2 = p;
            break;
          }
          default: {
            zipfileTableErr(pTab, "duplicate name: \"%s\"", zPath);
            rc = SQLITE_CONSTRAINT;
            break;
          }
          }
          break;
        }
      }
    }

    if (rc == SQLITE_OK) {
      /* Create the new CDS record. */
      pNew = zipfileNewEntry(zPath);
      if (pNew == 0) {
        rc = SQLITE_NOMEM;
      } else {
        pNew->cds.iVersionMadeBy = ZIPFILE_NEWENTRY_MADEBY;
        pNew->cds.iVersionExtract = ZIPFILE_NEWENTRY_REQUIRED;
        pNew->cds.flags = ZIPFILE_NEWENTRY_FLAGS;
        pNew->cds.iCompression = (u16)iMethod;
        zipfileMtimeToDos(&pNew->cds, mTime);
        pNew->cds.crc32 = iCrc32;
        pNew->cds.szCompressed = nData;
        pNew->cds.szUncompressed = (u32)sz;
        pNew->cds.iExternalAttr = (mode << 16);
        pNew->cds.iOffset = (u32)pTab->szCurrent;
        pNew->cds.nFile = (u16)nPath;
        pNew->mUnixTime = (u32)mTime;
        rc = zipfileAppendEntry(pTab, pNew, pData, nData);
        zipfileAddEntry(pTab, pOld, pNew);
      }
    }
  }

  if (rc == SQLITE_OK && (pOld || pOld2)) {
    ZipfileCsr *pCsr;
    for (pCsr = pTab->pCsrList; pCsr; pCsr = pCsr->pCsrNext) {
      if (pCsr->pCurrent &&
          (pCsr->pCurrent == pOld || pCsr->pCurrent == pOld2)) {
        pCsr->pCurrent = pCsr->pCurrent->pNext;
        pCsr->bNoop = 1;
      }
    }

    zipfileRemoveEntryFromList(pTab, pOld);
    zipfileRemoveEntryFromList(pTab, pOld2);
  }

zipfile_update_done:
  sqlite3_free(pFree);
  sqlite3_free(zFree);
  return rc;
}

