void __fastcall FoFiTrueType::cvtSfnts(
        const FoFiTrueType *this,
        FoFiOutputFunc outputFunc,
        void *outputStream,
        const GooString *name,
        bool needVerticalMetrics,
        int *maxUsedGlyph)
{
  int v9;
  int offset;
  const unsigned __int8 *file;
  __int128 v12;
  TrueTypeLoca *v13;
  int v14;
  TrueTypeTable *tables;
  int v16;
  FoFiTrueType *v17;
  int len;
  __int64 nGlyphs;
  int *p_origOffset;
  __int64 v21;
  int v22;
  signed int U32BE;
  __int64 v24;
  TrueTypeLoca *v25;
  int *v26;
  int origOffset;
  __int64 v28;
  int *v29;
  int v30;
  int v31;
  int v32;
  __int64 v33;
  FoFiTrueType *v34;
  __int64 v35;
  int *p_len;
  int v37;
  __int64 v38;
  int v39;
  unsigned __int8 *v40;
  FoFiTrueType *v41;
  __int64 v42;
  unsigned int newOffset;
  __int64 v44;
  __int64 v46;
  _BOOL4 v47;
  unsigned int v48;
  unsigned int v49;
  int v50;
  FoFiTrueType *v51;
  int v52;
  __int64 v53;
  int v54;
  int v55;
  unsigned __int8 *v56;
  int v57;
  unsigned int v58;
  TrueTypeTable *v59;
  int v60;
  FoFiTrueType *v61;
  __int64 v62;
  __int64 v63;
  int *v64;
  int v65;
  int v66;
  int v67;
  unsigned int v68;
  int v69;
  TrueTypeTable *v70;
  __int64 v71;
  bool v72;
  const unsigned __int8 *v73;
  int v74;
  _BYTE *v75;
  __int64 v76;
  int v77;
  int v78;
  __int64 v79;
  char *v80;
  int *v81;
  const FoFiTrueType *v82;
  unsigned int v83;
  unsigned int v84;
  __int64 v85;
  int v86;
  __int64 v87;
  __m128i v88;
  const __m128i *v89;
  __m128i v90;
  __int64 v91;
  __m128i v92;
  __m128i v93;
  __m128i v94;
  __m128i v95;
  int *v96;
  std::string *v97;
  FoFiTrueType *v98;
  FoFiOutputFunc v99;
  const std::string::value_type *v100;
  unsigned int Length;
  char *v102;
  FoFiTrueType *v103;
  __int64 v104;
  unsigned __int8 *v105;
  FoFiTrueType *v106;
  int *v107;
  __int64 v108;
  int v109;
  const unsigned __int8 *v110;
  TrueTypeTable *v111;
  int v112;
  __int64 v113;
  int *v114;
  __int64 v115;
  bool v116;
  int v117;
  int v118;
  __int64 v119;
  cmpTrueTypeLocaOffsetFunctor v120;
  cmpTrueTypeLocaIdxFunctor v121;
  bool ok;
  FoFiTrueType *v123;
  _BOOL4 v124;
  FoFiTrueType *v125;
  FoFiOutputFunc v126;
  int v127;
  int U16BE;
  int v129[2];
  void *v130;
  unsigned int v131;
  unsigned __int8 *v132;
  int *v133;
  void *p;
  int v135;
  int v136;
  __int128 v137;
  __int128 v138;
  int v139;
  std::string *v140;
  int *v141;
  __int64 v142;
  unsigned __int8 data[16];
  __m128i v144;
  _BYTE v145[22];
  unsigned __int8 s[4];
  char v147;
  char v148;
  int v149;
  char v150;
  char v151;
  char v152;
  int z[4];
  int v154[17];
  char v155;

  v124 = needVerticalMetrics;
  v137 = 0LL;
  v138 = 0LL;
  v139 = 0x1000000;
  BYTE1(v137) = 1;
  BYTE5(v138) = 1;
  *maxUsedGlyph = -1;
  v9 = FoFiTrueType::seekTable(this, "head");
  if ( v9 < 0 )
    return;
  if ( v9 >= this->nTables )
    return;
  offset = this->tables[v9].offset;
  v123 = (FoFiTrueType *)this;
  if ( !FoFiBase::checkRegion(this, offset, 54) )
    return;
  v133 = maxUsedGlyph;
  v140 = name;
  v125 = (FoFiTrueType *)outputStream;
  v126 = outputFunc;
  file = v123->file;
  v12 = *(_OWORD *)&file[offset + 32];
  *(__m128i *)data = _mm_loadu_si128((const __m128i *)&file[offset]);
  *(_QWORD *)&v145[14] = *(_QWORD *)&file[offset + 46];
  *(_OWORD *)v145 = v12;
  v144 = _mm_loadu_si128((const __m128i *)&file[offset + 16]);
  *(_DWORD *)&data[8] = 0;
  if ( v123->locaFmt >= 2u )
    *(_WORD *)&v145[18] = 256;
  v13 = (TrueTypeLoca *)gmallocn(v123->nGlyphs + 1, 16, 0);
  v14 = FoFiTrueType::seekTable(v123, "loca");
  tables = v123->tables;
  v16 = tables[v14].offset;
  v17 = v123;
  len = tables[FoFiTrueType::seekTable(v123, "glyf")].len;
  ok = 1;
  LODWORD(nGlyphs) = v123->nGlyphs;
  p = v13;
  if ( (int)nGlyphs >= 0 )
  {
    p_origOffset = &v13->origOffset;
    v21 = -1LL;
    v22 = v16;
    do
    {
      *(p_origOffset - 1) = v21 + 1;
      if ( v17->locaFmt )
        U32BE = FoFiBase::getU32BE(v17, v16, &ok);
      else
        U32BE = 2 * FoFiBase::getU16BE(v17, v22, &ok);
      if ( U32BE > len )
        U32BE = len;
      *p_origOffset = U32BE;
      nGlyphs = v17->nGlyphs;
      v22 += 2;
      p_origOffset += 4;
      ++v21;
      v16 += 4;
    }
    while ( v21 < nGlyphs );
    v13 = (TrueTypeLoca *)p;
  }
  std::sort<TrueTypeLoca *,cmpTrueTypeLocaOffsetFunctor>(v13, &v13[(int)nGlyphs + 1], v120);
  v24 = v17->nGlyphs;
  v25 = v13;
  v26 = v133;
  if ( v24 > 0 )
  {
    origOffset = v13->origOffset;
    if ( (_DWORD)v24 == 1 )
    {
      v28 = 0LL;
    }
    else
    {
      v29 = &v13[2].origOffset;
      v28 = 0LL;
      v30 = v13->origOffset;
      do
      {
        v31 = *(v29 - 4);
        origOffset = *v29;
        v32 = *v29 - v31;
        *(v29 - 6) = v31 - v30;
        v28 += 2LL;
        *(v29 - 2) = v32;
        v29 += 8;
        v30 = origOffset;
      }
      while ( v24 - (v24 & 1) != v28 );
      if ( (v24 & 1) == 0 )
        goto LABEL_22;
    }
    v25[v28].len = v25[v28 + 1].origOffset - origOffset;
  }
LABEL_22:
  v33 = v24;
  v25[v33].len = 0;
  std::sort<TrueTypeLoca *,cmpTrueTypeLocaIdxFunctor>(v25, &v25[v33 + 1], v121);
  v34 = v123;
  LODWORD(v35) = v123->nGlyphs;
  if ( (int)v35 >= 0 )
  {
    p_len = &v25->len;
    v37 = 0;
    v38 = -1LL;
    do
    {
      *(p_len - 1) = v37;
      if ( checkedAdd<int>(v37, *p_len, z) )
      {
        ok = 0;
      }
      else
      {
        v37 = z[0];
        if ( (z[0] & 3) != 0 )
          v37 = z[0] - (z[0] & 3) + 4;
      }
      v34 = v123;
      if ( *p_len > 0 )
        *v26 = v38 + 1;
      v35 = v34->nGlyphs;
      ++v38;
      p_len += 4;
    }
    while ( v38 < v35 );
  }
  v39 = 2 * (v34->locaFmt != 0) + 2;
  U16BE = 0;
  v40 = (unsigned __int8 *)gmallocn((int)v35 + 1, v39, 0);
  v41 = v123;
  if ( v123->nGlyphs >= 0 )
  {
    v42 = 0LL;
    do
    {
      newOffset = v25[v42].newOffset;
      if ( v41->locaFmt )
      {
        v46 = (unsigned int)(4 * v42);
        v40[v46] = HIBYTE(newOffset);
        v40[v46 + 1] = BYTE2(newOffset);
        v40[v46 + 2] = BYTE1(newOffset);
        v44 = (unsigned int)(4 * v42 + 3);
      }
      else
      {
        v40[2 * v42] = newOffset >> 9;
        newOffset >>= 1;
        v44 = v42 + v42 + 1;
      }
      v40[v44] = newOffset;
    }
    while ( v42++ < v41->nGlyphs );
  }
  v132 = v40;
  v47 = FoFiTrueType::seekTable(v41, "vhea") >= 0;
  v127 = (FoFiTrueType::seekTable(v41, "vmtx") >= 0) + v47 + 9;
  if ( v124 )
  {
    v48 = FoFiTrueType::seekTable(v41, "vhea");
    v49 = FoFiTrueType::seekTable(v41, "vmtx");
    if ( ((v48 | v49) & 0x80000000) != 0 )
    {
      v50 = FoFiTrueType::seekTable(v41, "head");
      U16BE = FoFiBase::getU16BE(v41, v41->tables[v50].offset + 18, &ok);
      v127 += (v48 >> 31) + (v49 >> 31);
    }
  }
  v51 = v41;
  *(_QWORD *)v129 = (unsigned int)(16 * v127);
  v52 = v129[0] + 12;
  v131 = (U16BE + ((unsigned int)(U16BE >> 31) >> 24)) >> 8;
  v141 = &v25->len;
  v53 = 0LL;
  v130 = 0LL;
  v54 = 0;
LABEL_45:
  if ( (_DWORD)v53 == 6 )
  {
    v55 = (v51->nGlyphs + 1) * (2 * (v51->locaFmt != 0) + 2);
    v58 = FoFiTrueType::computeTableChecksum(v51, v132, v55);
    if ( v55 < 0 )
      goto LABEL_78;
    goto LABEL_74;
  }
  if ( (_DWORD)v53 == 3 )
  {
    v55 = 54;
    v56 = data;
    v57 = 54;
LABEL_48:
    v58 = FoFiTrueType::computeTableChecksum(v51, v56, v57);
    goto LABEL_74;
  }
  v69 = FoFiTrueType::seekTable(v51, t42Tables[v53].tag);
  if ( v69 < 0 )
  {
    if ( v53 == 9 && v124 )
    {
      BYTE10(v137) = v131;
      BYTE11(v137) = U16BE;
      v55 = 36;
      v56 = (unsigned __int8 *)&v137;
      v57 = 36;
      goto LABEL_48;
    }
    if ( v53 == 10 && v124 )
    {
      v74 = v123->nGlyphs;
      v55 = 2 * v74 + 2;
      v51 = (FoFiTrueType *)v55;
      v75 = gmalloc(v55, 0);
      *v75 = v131;
      v75[1] = U16BE;
      v130 = v75;
      if ( v55 >= 3 )
      {
        v51 = (FoFiTrueType *)((char *)v130 + 2);
        memset((char *)v130 + 2, 0, (unsigned int)(2 * v74 - 2) + 2LL);
        v75 = v130;
      }
      v73 = v75;
      goto LABEL_72;
    }
    v58 = 0;
    v55 = 0;
    if ( (unsigned __int64)(v53 - 9) <= 1 )
      goto LABEL_78;
LABEL_74:
    v76 = 5LL * v54;
    z[v76] = _byteswap_ulong(*(_DWORD *)t42Tables[v53].tag);
    z[v76 + 1] = v58;
    z[v76 + 2] = v52;
    v154[v76] = v55;
    if ( checkedAdd<int>(v52, v55, (int *)s) )
    {
      ok = 0;
    }
    else
    {
      v52 = *(_DWORD *)s;
      if ( (s[0] & 3) != 0 )
        v52 = *(_DWORD *)s - (v55 & 3) + 4;
    }
    v51 = v123;
    ++v54;
    goto LABEL_43;
  }
  v70 = v51->tables;
  v71 = v69;
  v55 = v70[v69].len;
  v72 = FoFiBase::checkRegion(v51, v70[v69].offset, v55);
  v58 = 0;
  if ( v72 )
  {
    v73 = &v51->file[v51->tables[v71].offset];
LABEL_72:
    v58 = FoFiTrueType::computeTableChecksum(v51, v73, v55);
  }
  if ( v55 >= 0 )
    goto LABEL_74;
LABEL_78:
  while ( 1 )
  {
    v51 = v123;
LABEL_43:
    if ( ++v53 == 11 )
      break;
    if ( (_DWORD)v53 != 2 )
      goto LABEL_45;
    v59 = v51->tables;
    v60 = FoFiTrueType::seekTable(v51, "glyf");
    v61 = v123;
    if ( v123->nGlyphs <= 0 )
    {
      v58 = 0;
      v55 = 0;
      goto LABEL_74;
    }
    v142 = v53;
    v135 = v52;
    v136 = v54;
    v62 = v59[v60].offset;
    v63 = 0LL;
    v64 = v141;
    LODWORD(v133) = 0;
    v55 = 0;
    do
    {
      v65 = *v64 + v55;
      v66 = ((unsigned __int8)*v64 + (_BYTE)v55) & 3;
      v67 = 4 - v66;
      if ( !v66 )
        v67 = 0;
      if ( FoFiBase::checkRegion(v61, v62 + *(v64 - 2), *v64) )
      {
        v68 = FoFiTrueType::computeTableChecksum(v61, &v61->file[v62 + *(v64 - 2)], *v64);
        LODWORD(v133) = v68 + (_DWORD)v133;
      }
      v55 = v65 + v67;
      ++v63;
      v64 += 4;
    }
    while ( v63 < v61->nGlyphs );
    v54 = v136;
    v52 = v135;
    v53 = v142;
    v58 = (unsigned int)v133;
    if ( v55 >= 0 )
      goto LABEL_74;
  }
  v77 = v127;
  if ( v54 < v127 )
  {
    v51 = 0LL;
    error(ErrorCategory::errSyntaxWarning, -1LL, "unexpected number of tables");
    *(_QWORD *)v129 = (unsigned int)(16 * v54);
    v77 = v54;
  }
  *(_DWORD *)s = 256;
  v147 = 0;
  v148 = v77;
  v149 = 50364416;
  v150 = 0;
  v78 = v129[0];
  v151 = LOBYTE(v129[0]) ^ 0x80;
  v79 = v77;
  if ( v77 <= 0 )
  {
    v86 = v129[0] | 0xC;
    *(_QWORD *)v129 = v129[0] | 0xCu;
    v84 = FoFiTrueType::computeTableChecksum(v51, s, v86);
  }
  else
  {
    v80 = &v152;
    v81 = v154;
    v82 = 0LL;
    do
    {
      *(_DWORD *)(v80 - 15) = _byteswap_ulong(*(v81 - 4));
      *(_DWORD *)(v80 - 11) = _byteswap_ulong(*(v81 - 3));
      *(_DWORD *)(v80 - 7) = _byteswap_ulong(*(v81 - 2));
      *(_DWORD *)(v80 - 3) = _byteswap_ulong(*v81);
      v82 = (const FoFiTrueType *)((char *)v82 + 1);
      v80 += 16;
      v81 += 5;
    }
    while ( (__int64)v82 < v77 );
    v83 = v78 | 0xC;
    *(_QWORD *)v129 = v83;
    v84 = FoFiTrueType::computeTableChecksum(v82, s, v83);
    if ( (unsigned int)v77 >= 9 )
    {
      v87 = 8LL;
      if ( (v77 & 7) != 0 )
        v87 = v77 & 7;
      v85 = v77 - v87;
      v88 = _mm_cvtsi32_si128(v84);
      v89 = (const __m128i *)&v155;
      v90 = 0LL;
      v91 = v85;
      do
      {
        v92 = _mm_unpackhi_epi32(_mm_shuffle_epi32(_mm_loadu_si128(v89 - 3), 164), _mm_loadu_si128(v89 - 2));
        v92.m128i_i64[0] = _mm_unpacklo_epi32(
                             _mm_loadu_si128(v89 - 5),
                             _mm_shuffle_epi32(_mm_loadu_si128(v89 - 4), 229)).m128i_i64[0];
        v88 = _mm_add_epi32(v88, v92);
        v93 = _mm_unpackhi_epi32(_mm_shuffle_epi32(_mm_loadu_si128(v89 + 2), 164), _mm_loadu_si128(v89 + 3));
        v93.m128i_i64[0] = _mm_unpacklo_epi32(_mm_loadu_si128(v89), _mm_shuffle_epi32(_mm_loadu_si128(v89 + 1), 229)).m128i_i64[0];
        v90 = _mm_add_epi32(v90, v93);
        v89 += 10;
        v91 -= 8LL;
      }
      while ( v91 );
      v94 = _mm_add_epi32(v90, v88);
      v95 = _mm_add_epi32(_mm_shuffle_epi32(v94, 78), v94);
      v84 = _mm_cvtsi128_si32(_mm_add_epi32(_mm_shuffle_epi32(v95, 229), v95));
    }
    else
    {
      v85 = 0LL;
    }
    v96 = &z[5 * v85 + 1];
    do
    {
      v84 += *v96;
      ++v85;
      v96 += 5;
    }
    while ( v85 < v77 );
  }
  *(_DWORD *)&data[8] = _byteswap_ulong(-1313820742 - v84);
  v97 = v140;
  if ( v140 )
  {
    v98 = v125;
    v99 = v126;
    v126(v125, "/", 1);
    v100 = std::string::c_str(v97);
    Length = GooString::getLength(v97);
    v99(v98, v100, Length);
    v102 = " [\n";
    v103 = v98;
    v104 = 3LL;
  }
  else
  {
    v102 = "/sfnts [\n";
    v98 = v125;
    v103 = v125;
    v104 = 9LL;
    v99 = v126;
  }
  v99(v103, v102, v104);
  v105 = v132;
  FoFiTrueType::dumpString(v103, s, v129[0], v99, v98);
  v106 = v123;
  if ( v77 > 0 )
  {
    v107 = (int *)((char *)p + 12);
    v108 = 0LL;
LABEL_103:
    if ( (_DWORD)v108 == 6 )
    {
      v109 = (v106->nGlyphs + 1) * (2 * (v106->locaFmt != 0) + 2);
      v110 = v105;
LABEL_100:
      FoFiTrueType::dumpString(v106, v110, v109, v126, v125);
      v106 = v123;
      goto LABEL_101;
    }
    if ( (_DWORD)v108 == 3 )
    {
      v110 = data;
      v109 = 54;
      goto LABEL_100;
    }
    v117 = v154[5 * v108];
    if ( v117 <= 0 )
      goto LABEL_101;
    v118 = FoFiTrueType::seekTable(v106, t42Tables[v108].tag);
    if ( v118 >= 0 )
    {
      v119 = v118;
      if ( FoFiBase::checkRegion(v106, v106->tables[v118].offset, v106->tables[v118].len) )
      {
        FoFiTrueType::dumpString(v106, &v106->file[v106->tables[v119].offset], v106->tables[v119].len, v126, v125);
        goto LABEL_101;
      }
    }
    if ( v108 == 9 && v124 )
    {
      v110 = (const unsigned __int8 *)&v137;
LABEL_122:
      v109 = v117;
      goto LABEL_100;
    }
    v106 = v123;
    if ( v108 == 10 && v124 )
    {
      v110 = (const unsigned __int8 *)v130;
      goto LABEL_122;
    }
LABEL_101:
    while ( 1 )
    {
      ++v108;
      v105 = v132;
      if ( v108 >= v79 )
        break;
      if ( (_DWORD)v108 != 2 )
        goto LABEL_103;
      v111 = v106->tables;
      v112 = FoFiTrueType::seekTable(v106, "glyf");
      v106 = v123;
      if ( v123->nGlyphs > 0 )
      {
        v113 = v111[v112].offset;
        v114 = v107;
        v115 = 0LL;
        do
        {
          if ( *v114 > 0 )
          {
            v116 = FoFiBase::checkRegion(v106, v113 + *(v114 - 2), *v114);
            v106 = v123;
            if ( v116 )
            {
              FoFiTrueType::dumpString(v123, &v123->file[v113 + *(v114 - 2)], *v114, v126, v125);
              v106 = v123;
            }
          }
          ++v115;
          v114 += 4;
        }
        while ( v115 < v106->nGlyphs );
      }
    }
  }
  v126(v125, "] def\n", 6);
  gfree(v105);
  gfree(p);
  if ( v130 )
    gfree(v130);
}
