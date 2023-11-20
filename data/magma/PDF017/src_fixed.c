void FoFiTrueType::cvtSfnts(FoFiOutputFunc outputFunc, void *outputStream,
                            const GooString *name, bool needVerticalMetrics,
                            int *maxUsedGlyph) const {
  unsigned char headData[54];
  TrueTypeLoca *locaTable;
  unsigned char *locaData;
  TrueTypeTable newTables[nT42Tables];
  unsigned char tableDir[12 + nT42Tables * 16];
  bool ok;
  unsigned int checksum;
  int nNewTables;
  int glyfTableLen, length, pos, glyfPos, i, j, k, vmtxTabLength;
  unsigned char vheaTab[36] = {
      0, 1, 0, 0, // table version number
      0, 0,       // ascent
      0, 0,       // descent
      0, 0,       // reserved
      0, 0,       // max advance height
      0, 0,       // min top side bearing
      0, 0,       // min bottom side bearing
      0, 0,       // y max extent
      0, 0,       // caret slope rise
      0, 1,       // caret slope run
      0, 0,       // caret offset
      0, 0,       // reserved
      0, 0,       // reserved
      0, 0,       // reserved
      0, 0,       // reserved
      0, 0,       // metric data format
      0, 1        // number of advance heights in vmtx table
  };
  unsigned char *vmtxTab;
  bool needVhea, needVmtx;
  int advance;

  *maxUsedGlyph = -1;

  // construct the 'head' table, zero out the font checksum
  i = seekTable("head");
  if (i < 0 || i >= nTables) {
    return;
  }
  pos = tables[i].offset;
  if (!checkRegion(pos, 54)) {
    return;
  }
  memcpy(headData, file + pos, 54);
  headData[8] = headData[9] = headData[10] = headData[11] = (unsigned char)0;

  // check for a bogus loca format field in the 'head' table
  // (I've encountered fonts with loca format set to 0x0100 instead of 0x0001)
  if (locaFmt != 0 && locaFmt != 1) {
    headData[50] = 0;
    headData[51] = 1;
  }

  // read the original 'loca' table, pad entries out to 4 bytes, and
  // sort it into proper order -- some (non-compliant) fonts have
  // out-of-order loca tables; in order to correctly handle the case
  // where (compliant) fonts have empty entries in the middle of the
  // table, cmpTrueTypeLocaOffset uses offset as its primary sort key,
  // and idx as its secondary key (ensuring that adjacent entries with
  // the same pos value remain in the same order)
  locaTable = (TrueTypeLoca *)gmallocn(nGlyphs + 1, sizeof(TrueTypeLoca));
  i = seekTable("loca");
  pos = tables[i].offset;
  i = seekTable("glyf");
  glyfTableLen = tables[i].len;
  ok = true;
  for (i = 0; i <= nGlyphs; ++i) {
    locaTable[i].idx = i;
    if (locaFmt) {
      locaTable[i].origOffset = (int)getU32BE(pos + i * 4, &ok);
    } else {
      locaTable[i].origOffset = 2 * getU16BE(pos + i * 2, &ok);
    }
    if (locaTable[i].origOffset > glyfTableLen) {
      locaTable[i].origOffset = glyfTableLen;
    }
  }
  std::sort(locaTable, locaTable + nGlyphs + 1, cmpTrueTypeLocaOffsetFunctor());
  for (i = 0; i < nGlyphs; ++i) {
    locaTable[i].len = locaTable[i + 1].origOffset - locaTable[i].origOffset;
  }
  locaTable[nGlyphs].len = 0;
  std::sort(locaTable, locaTable + nGlyphs + 1, cmpTrueTypeLocaIdxFunctor());
  pos = 0;
  for (i = 0; i <= nGlyphs; ++i) {
    locaTable[i].newOffset = pos;

    int newPos;
    if (unlikely(checkedAdd(pos, locaTable[i].len, &newPos))) {
      ok = false;
    } else {
      pos = newPos;
      if (pos & 3) {
        pos += 4 - (pos & 3);
      }
    }
    if (locaTable[i].len > 0) {
      *maxUsedGlyph = i;
    }
  }

  // construct the new 'loca' table
  locaData = (unsigned char *)gmallocn(nGlyphs + 1, (locaFmt ? 4 : 2));
  for (i = 0; i <= nGlyphs; ++i) {
    pos = locaTable[i].newOffset;
    if (locaFmt) {
      locaData[4 * i] = (unsigned char)(pos >> 24);
      locaData[4 * i + 1] = (unsigned char)(pos >> 16);
      locaData[4 * i + 2] = (unsigned char)(pos >> 8);
      locaData[4 * i + 3] = (unsigned char)pos;
    } else {
      locaData[2 * i] = (unsigned char)(pos >> 9);
      locaData[2 * i + 1] = (unsigned char)(pos >> 1);
    }
  }

  // count the number of tables
  nNewTables = 0;
  for (i = 0; i < nT42Tables; ++i) {
    if (t42Tables[i].required || seekTable(t42Tables[i].tag) >= 0) {
      ++nNewTables;
    }
  }
  vmtxTab = nullptr; // make gcc happy
  vmtxTabLength = 0;
  advance = 0; // make gcc happy
  if (needVerticalMetrics) {
    needVhea = seekTable("vhea") < 0;
    needVmtx = seekTable("vmtx") < 0;
    if (needVhea || needVmtx) {
      i = seekTable("head");
      advance = getU16BE(tables[i].offset + 18, &ok); // units per em
      if (needVhea) {
        ++nNewTables;
      }
      if (needVmtx) {
        ++nNewTables;
      }
    }
  }

  // construct the new table headers, including table checksums
  // (pad each table out to a multiple of 4 bytes)
  pos = 12 + nNewTables * 16;
  k = 0;
  for (i = 0; i < nT42Tables; ++i) {
    length = -1;
    checksum = 0; // make gcc happy
    if (i == t42HeadTable) {
      length = 54;
      checksum = computeTableChecksum(headData, 54);
    } else if (i == t42LocaTable) {
      length = (nGlyphs + 1) * (locaFmt ? 4 : 2);
      checksum = computeTableChecksum(locaData, length);
    } else if (i == t42GlyfTable) {
      length = 0;
      checksum = 0;
      glyfPos = tables[seekTable("glyf")].offset;
      for (j = 0; j < nGlyphs; ++j) {
        length += locaTable[j].len;
        if (length & 3) {
          length += 4 - (length & 3);
        }
        if (checkRegion(glyfPos + locaTable[j].origOffset, locaTable[j].len)) {
          checksum += computeTableChecksum(
              file + glyfPos + locaTable[j].origOffset, locaTable[j].len);
        }
      }
    } else {
      if ((j = seekTable(t42Tables[i].tag)) >= 0) {
        length = tables[j].len;
        if (checkRegion(tables[j].offset, length)) {
          checksum = computeTableChecksum(file + tables[j].offset, length);
        }
      } else if (needVerticalMetrics && i == t42VheaTable) {
        vheaTab[10] = advance / 256; // max advance height
        vheaTab[11] = advance % 256;
        length = sizeof(vheaTab);
        checksum = computeTableChecksum(vheaTab, length);
      } else if (needVerticalMetrics && i == t42VmtxTable) {
        length = 4 + (nGlyphs - 1) * 2;
        vmtxTabLength = length;
        vmtxTab = (unsigned char *)gmalloc(length);
        vmtxTab[0] = advance / 256;
        vmtxTab[1] = advance % 256;
        for (j = 2; j < length; j += 2) {
          vmtxTab[j] = 0;
          vmtxTab[j + 1] = 0;
        }
        checksum = computeTableChecksum(vmtxTab, length);
      } else if (t42Tables[i].required) {
        //~ error(-1, "Embedded TrueType font is missing a required table
        //('%s')", ~       t42Tables[i].tag);
        length = 0;
        checksum = 0;
      }
    }
    if (length >= 0) {
      newTables[k].tag = ((t42Tables[i].tag[0] & 0xff) << 24) |
                         ((t42Tables[i].tag[1] & 0xff) << 16) |
                         ((t42Tables[i].tag[2] & 0xff) << 8) |
                         (t42Tables[i].tag[3] & 0xff);
      newTables[k].checksum = checksum;
      newTables[k].offset = pos;
      newTables[k].len = length;
      int newPos;
      if (unlikely(checkedAdd(pos, length, &newPos))) {
        ok = false;
      } else {
        pos = newPos;
        if (pos & 3) {
          pos += 4 - (length & 3);
        }
      }
      ++k;
    }
  }
  if (unlikely(k < nNewTables)) {
    error(errSyntaxWarning, -1, "unexpected number of tables");
    nNewTables = k;
  }

  // construct the table directory
  tableDir[0] = 0x00; // sfnt version
  tableDir[1] = 0x01;
  tableDir[2] = 0x00;
  tableDir[3] = 0x00;
  tableDir[4] = 0; // numTables
  tableDir[5] = nNewTables;
  tableDir[6] = 0; // searchRange
  tableDir[7] = (unsigned char)128;
  tableDir[8] = 0; // entrySelector
  tableDir[9] = 3;
  tableDir[10] = 0; // rangeShift
  tableDir[11] = (unsigned char)(16 * nNewTables - 128);
  pos = 12;
  for (i = 0; i < nNewTables; ++i) {
    tableDir[pos] = (unsigned char)(newTables[i].tag >> 24);
    tableDir[pos + 1] = (unsigned char)(newTables[i].tag >> 16);
    tableDir[pos + 2] = (unsigned char)(newTables[i].tag >> 8);
    tableDir[pos + 3] = (unsigned char)newTables[i].tag;
    tableDir[pos + 4] = (unsigned char)(newTables[i].checksum >> 24);
    tableDir[pos + 5] = (unsigned char)(newTables[i].checksum >> 16);
    tableDir[pos + 6] = (unsigned char)(newTables[i].checksum >> 8);
    tableDir[pos + 7] = (unsigned char)newTables[i].checksum;
    tableDir[pos + 8] = (unsigned char)(newTables[i].offset >> 24);
    tableDir[pos + 9] = (unsigned char)(newTables[i].offset >> 16);
    tableDir[pos + 10] = (unsigned char)(newTables[i].offset >> 8);
    tableDir[pos + 11] = (unsigned char)newTables[i].offset;
    tableDir[pos + 12] = (unsigned char)(newTables[i].len >> 24);
    tableDir[pos + 13] = (unsigned char)(newTables[i].len >> 16);
    tableDir[pos + 14] = (unsigned char)(newTables[i].len >> 8);
    tableDir[pos + 15] = (unsigned char)newTables[i].len;
    pos += 16;
  }

  // compute the font checksum and store it in the head table
  checksum = computeTableChecksum(tableDir, 12 + nNewTables * 16);
  for (i = 0; i < nNewTables; ++i) {
    checksum += newTables[i].checksum;
  }
  checksum = 0xb1b0afba - checksum; // because the TrueType spec says so
  headData[8] = (unsigned char)(checksum >> 24);
  headData[9] = (unsigned char)(checksum >> 16);
  headData[10] = (unsigned char)(checksum >> 8);
  headData[11] = (unsigned char)checksum;

  // start the sfnts array
  if (name) {
    (*outputFunc)(outputStream, "/", 1);
    (*outputFunc)(outputStream, name->c_str(), name->getLength());
    (*outputFunc)(outputStream, " [\n", 3);
  } else {
    (*outputFunc)(outputStream, "/sfnts [\n", 9);
  }

  // write the table directory
  dumpString(tableDir, 12 + nNewTables * 16, outputFunc, outputStream);

  // write the tables
  for (i = 0; i < nNewTables; ++i) {
    if (i == t42HeadTable) {
      dumpString(headData, 54, outputFunc, outputStream);
    } else if (i == t42LocaTable) {
      length = (nGlyphs + 1) * (locaFmt ? 4 : 2);
      dumpString(locaData, length, outputFunc, outputStream);
    } else if (i == t42GlyfTable) {
      glyfPos = tables[seekTable("glyf")].offset;
      for (j = 0; j < nGlyphs; ++j) {
        if (locaTable[j].len > 0 &&
            checkRegion(glyfPos + locaTable[j].origOffset, locaTable[j].len)) {
          dumpString(file + glyfPos + locaTable[j].origOffset, locaTable[j].len,
                     outputFunc, outputStream);
        }
      }
    } else {
      // length == 0 means the table is missing and the error was
      // already reported during the construction of the table
      // headers
      if ((length = newTables[i].len) > 0) {
        if ((j = seekTable(t42Tables[i].tag)) >= 0 &&
            checkRegion(tables[j].offset, tables[j].len)) {
          dumpString(file + tables[j].offset, tables[j].len, outputFunc,
                     outputStream);
        } else if (needVerticalMetrics && i == t42VheaTable) {
          if (unlikely(length > (int)sizeof(vheaTab))) {
            error(errSyntaxWarning, -1, "length bigger than vheaTab size");
            length = sizeof(vheaTab);
          }
          dumpString(vheaTab, length, outputFunc, outputStream);
        } else if (needVerticalMetrics && i == t42VmtxTable) {
          if (unlikely(length > vmtxTabLength)) {
            error(errSyntaxWarning, -1, "length bigger than vmtxTab size");
            length = vmtxTabLength;
          }
          dumpString(vmtxTab, length, outputFunc, outputStream);
        }
      }
    }
  }

  // end the sfnts array
  (*outputFunc)(outputStream, "] def\n", 6);

  gfree(locaData);
  gfree(locaTable);
  if (vmtxTab) {
    gfree(vmtxTab);
  }
}
