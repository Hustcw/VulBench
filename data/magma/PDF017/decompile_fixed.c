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
  int v51;
  __int64 v52;
  int v53;
  int v54;
  unsigned __int8 *v55;
  int v56;
  unsigned int v57;
  TrueTypeTable *v58;
  int v59;
  FoFiTrueType *v60;
  __int64 v61;
  __int64 v62;
  int *v63;
  int v64;
  int v65;
  int v66;
  unsigned int v67;
  int v68;
  TrueTypeTable *v69;
  __int64 v70;
  bool v71;
  int v72;
  const FoFiTrueType *v73;
  _BYTE *v74;
  __int64 v75;
  int v76;
  int v77;
  __int64 v78;
  char *v79;
  int *v80;
  const FoFiTrueType *v81;
  unsigned int v82;
  unsigned int v83;
  __int64 v84;
  int v85;
  __int64 v86;
  __m128i v87;
  const __m128i *v88;
  __m128i v89;
  __int64 v90;
  __m128i v91;
  __m128i v92;
  __m128i v93;
  __m128i v94;
  int *v95;
  std::string *v96;
  FoFiTrueType *v97;
  FoFiOutputFunc v98;
  const std::string::value_type *v99;
  unsigned int Length;
  char *v101;
  FoFiTrueType *v102;
  __int64 v103;
  unsigned __int8 *v104;
  FoFiTrueType *v105;
  int *v106;
  __int64 v107;
  int v108;
  const unsigned __int8 *v109;
  TrueTypeTable *v110;
  int v111;
  __int64 v112;
  int *v113;
  __int64 v114;
  bool v115;
  int v116;
  int v117;
  __int64 v118;
  cmpTrueTypeLocaOffsetFunctor v119;
  cmpTrueTypeLocaIdxFunctor v120;
  bool ok;
  FoFiTrueType *v122;
  _BOOL4 v123;
  FoFiTrueType *v124;
  FoFiOutputFunc v125;
  int v126;
  int U16BE;
  int v128;
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

  v123 = needVerticalMetrics;
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
  v122 = (FoFiTrueType *)this;
  if ( !FoFiBase::checkRegion(this, offset, 54) )
    return;
  v133 = maxUsedGlyph;
  v140 = name;
  v124 = (FoFiTrueType *)outputStream;
  v125 = outputFunc;
  file = v122->file;
  v12 = *(_OWORD *)&file[offset + 32];
  *(__m128i *)data = _mm_loadu_si128((const __m128i *)&file[offset]);
  *(_QWORD *)&v145[14] = *(_QWORD *)&file[offset + 46];
  *(_OWORD *)v145 = v12;
  v144 = _mm_loadu_si128((const __m128i *)&file[offset + 16]);
  *(_DWORD *)&data[8] = 0;
  if ( v122->locaFmt >= 2u )
    *(_WORD *)&v145[18] = 256;
  v13 = (TrueTypeLoca *)gmallocn(v122->nGlyphs + 1, 16, 0);
  v14 = FoFiTrueType::seekTable(v122, "loca");
  tables = v122->tables;
  v16 = tables[v14].offset;
  v17 = v122;
  len = tables[FoFiTrueType::seekTable(v122, "glyf")].len;
  ok = 1;
  LODWORD(nGlyphs) = v122->nGlyphs;
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
  std::sort<TrueTypeLoca *,cmpTrueTypeLocaOffsetFunctor>(v13, &v13[(int)nGlyphs + 1], v119);
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
  std::sort<TrueTypeLoca *,cmpTrueTypeLocaIdxFunctor>(v25, &v25[v33 + 1], v120);
  v34 = v122;
  LODWORD(v35) = v122->nGlyphs;
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
      v34 = v122;
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
  v41 = v122;
  if ( v122->nGlyphs >= 0 )
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
  v126 = v47 + (FoFiTrueType::seekTable(v41, "vmtx") >= 0) + 9;
  if ( v123 )
  {
    v48 = FoFiTrueType::seekTable(v41, "vhea");
    v49 = FoFiTrueType::seekTable(v41, "vmtx");
    if ( ((v48 | v49) & 0x80000000) != 0 )
    {
      v50 = FoFiTrueType::seekTable(v41, "head");
      U16BE = FoFiBase::getU16BE(v41, v41->tables[v50].offset + 18, &ok);
      v126 += (v48 >> 31) + (v49 >> 31);
    }
  }
  *(_QWORD *)v129 = (unsigned int)(16 * v126);
  v51 = v129[0] + 12;
  v131 = (U16BE + ((unsigned int)(U16BE >> 31) >> 24)) >> 8;
  v141 = &v25->len;
  v52 = 0LL;
  v130 = 0LL;
  v128 = 0;
  v53 = 0;
LABEL_45:
  if ( (_DWORD)v52 == 6 )
  {
    v54 = (v41->nGlyphs + 1) * (2 * (v41->locaFmt != 0) + 2);
    v57 = FoFiTrueType::computeTableChecksum(v41, v132, v54);
    if ( v54 < 0 )
      goto LABEL_77;
    goto LABEL_73;
  }
  if ( (_DWORD)v52 == 3 )
  {
    v54 = 54;
    v55 = data;
    v56 = 54;
LABEL_48:
    v57 = FoFiTrueType::computeTableChecksum(v41, v55, v56);
    goto LABEL_73;
  }
  v68 = FoFiTrueType::seekTable(v41, t42Tables[v52].tag);
  if ( v68 < 0 )
  {
    if ( v52 == 9 && v123 )
    {
      BYTE10(v137) = v131;
      BYTE11(v137) = U16BE;
      v54 = 36;
      v55 = (unsigned __int8 *)&v137;
      v56 = 36;
      goto LABEL_48;
    }
    if ( v52 == 10 && v123 )
    {
      v72 = v122->nGlyphs;
      v54 = 2 * v72 + 2;
      v73 = (const FoFiTrueType *)v54;
      v74 = gmalloc(v54, 0);
      *v74 = v131;
      v74[1] = U16BE;
      v130 = v74;
      if ( v54 >= 3 )
      {
        v73 = (const FoFiTrueType *)((char *)v130 + 2);
        memset((char *)v130 + 2, 0, (unsigned int)(2 * v72 - 2) + 2LL);
        v74 = v130;
      }
      v57 = FoFiTrueType::computeTableChecksum(v73, v74, v54);
      v128 = 2 * v72 + 2;
      goto LABEL_72;
    }
    v57 = 0;
    v54 = 0;
    if ( (unsigned __int64)(v52 - 9) <= 1 )
      goto LABEL_77;
LABEL_73:
    v75 = 5LL * v53;
    z[v75] = _byteswap_ulong(*(_DWORD *)t42Tables[v52].tag);
    z[v75 + 1] = v57;
    z[v75 + 2] = v51;
    v154[v75] = v54;
    if ( checkedAdd<int>(v51, v54, (int *)s) )
    {
      ok = 0;
    }
    else
    {
      v51 = *(_DWORD *)s;
      if ( (s[0] & 3) != 0 )
        v51 = *(_DWORD *)s - (v54 & 3) + 4;
    }
    v41 = v122;
    ++v53;
    goto LABEL_43;
  }
  v69 = v41->tables;
  v70 = v68;
  v54 = v69[v68].len;
  v71 = FoFiBase::checkRegion(v41, v69[v68].offset, v54);
  v57 = 0;
  if ( v71 )
    v57 = FoFiTrueType::computeTableChecksum(v41, &v41->file[v41->tables[v70].offset], v54);
LABEL_72:
  if ( v54 >= 0 )
    goto LABEL_73;
LABEL_77:
  while ( 1 )
  {
    v41 = v122;
LABEL_43:
    if ( ++v52 == 11 )
      break;
    if ( (_DWORD)v52 != 2 )
      goto LABEL_45;
    v58 = v41->tables;
    v59 = FoFiTrueType::seekTable(v41, "glyf");
    v60 = v122;
    if ( v122->nGlyphs <= 0 )
    {
      v57 = 0;
      v54 = 0;
      goto LABEL_73;
    }
    v142 = v52;
    v135 = v53;
    v136 = v51;
    v61 = v58[v59].offset;
    v62 = 0LL;
    v63 = v141;
    LODWORD(v133) = 0;
    v54 = 0;
    do
    {
      v64 = *v63 + v54;
      v65 = ((unsigned __int8)*v63 + (_BYTE)v54) & 3;
      v66 = 4 - v65;
      if ( !v65 )
        v66 = 0;
      if ( FoFiBase::checkRegion(v60, v61 + *(v63 - 2), *v63) )
      {
        v67 = FoFiTrueType::computeTableChecksum(v60, &v60->file[v61 + *(v63 - 2)], *v63);
        LODWORD(v133) = v67 + (_DWORD)v133;
      }
      v54 = v64 + v66;
      ++v62;
      v63 += 4;
    }
    while ( v62 < v60->nGlyphs );
    v51 = v136;
    v53 = v135;
    v52 = v142;
    v57 = (unsigned int)v133;
    if ( v54 >= 0 )
      goto LABEL_73;
  }
  v76 = v126;
  if ( v53 < v126 )
  {
    v41 = 0LL;
    error(ErrorCategory::errSyntaxWarning, -1LL, "unexpected number of tables");
    *(_QWORD *)v129 = (unsigned int)(16 * v53);
    v76 = v53;
  }
  *(_DWORD *)s = 256;
  v147 = 0;
  v148 = v76;
  v149 = 50364416;
  v150 = 0;
  v77 = v129[0];
  v151 = LOBYTE(v129[0]) ^ 0x80;
  v78 = v76;
  if ( v76 <= 0 )
  {
    v85 = v129[0] | 0xC;
    *(_QWORD *)v129 = v129[0] | 0xCu;
    v83 = FoFiTrueType::computeTableChecksum(v41, s, v85);
  }
  else
  {
    v79 = &v152;
    v80 = v154;
    v81 = 0LL;
    do
    {
      *(_DWORD *)(v79 - 15) = _byteswap_ulong(*(v80 - 4));
      *(_DWORD *)(v79 - 11) = _byteswap_ulong(*(v80 - 3));
      *(_DWORD *)(v79 - 7) = _byteswap_ulong(*(v80 - 2));
      *(_DWORD *)(v79 - 3) = _byteswap_ulong(*v80);
      v81 = (const FoFiTrueType *)((char *)v81 + 1);
      v79 += 16;
      v80 += 5;
    }
    while ( (__int64)v81 < v76 );
    v82 = v77 | 0xC;
    *(_QWORD *)v129 = v82;
    v83 = FoFiTrueType::computeTableChecksum(v81, s, v82);
    if ( (unsigned int)v76 >= 9 )
    {
      v86 = 8LL;
      if ( (v76 & 7) != 0 )
        v86 = v76 & 7;
      v84 = v76 - v86;
      v87 = _mm_cvtsi32_si128(v83);
      v88 = (const __m128i *)&v155;
      v89 = 0LL;
      v90 = v84;
      do
      {
        v91 = _mm_unpackhi_epi32(_mm_shuffle_epi32(_mm_loadu_si128(v88 - 3), 164), _mm_loadu_si128(v88 - 2));
        v91.m128i_i64[0] = _mm_unpacklo_epi32(
                             _mm_loadu_si128(v88 - 5),
                             _mm_shuffle_epi32(_mm_loadu_si128(v88 - 4), 229)).m128i_i64[0];
        v87 = _mm_add_epi32(v87, v91);
        v92 = _mm_unpackhi_epi32(_mm_shuffle_epi32(_mm_loadu_si128(v88 + 2), 164), _mm_loadu_si128(v88 + 3));
        v92.m128i_i64[0] = _mm_unpacklo_epi32(_mm_loadu_si128(v88), _mm_shuffle_epi32(_mm_loadu_si128(v88 + 1), 229)).m128i_i64[0];
        v89 = _mm_add_epi32(v89, v92);
        v88 += 10;
        v90 -= 8LL;
      }
      while ( v90 );
      v93 = _mm_add_epi32(v89, v87);
      v94 = _mm_add_epi32(_mm_shuffle_epi32(v93, 78), v93);
      v83 = _mm_cvtsi128_si32(_mm_add_epi32(_mm_shuffle_epi32(v94, 229), v94));
    }
    else
    {
      v84 = 0LL;
    }
    v95 = &z[5 * v84 + 1];
    do
    {
      v83 += *v95;
      ++v84;
      v95 += 5;
    }
    while ( v84 < v76 );
  }
  *(_DWORD *)&data[8] = _byteswap_ulong(-1313820742 - v83);
  v96 = v140;
  if ( v140 )
  {
    v97 = v124;
    v98 = v125;
    v125(v124, "/", 1);
    v99 = std::string::c_str(v96);
    Length = GooString::getLength(v96);
    v98(v97, v99, Length);
    v101 = " [\n";
    v102 = v97;
    v103 = 3LL;
  }
  else
  {
    v101 = "/sfnts [\n";
    v97 = v124;
    v102 = v124;
    v103 = 9LL;
    v98 = v125;
  }
  v98(v102, v101, v103);
  v104 = v132;
  FoFiTrueType::dumpString(v102, s, v129[0], v98, v97);
  v105 = v122;
  if ( v76 > 0 )
  {
    v106 = (int *)((char *)p + 12);
    v107 = 0LL;
LABEL_102:
    if ( (_DWORD)v107 == 6 )
    {
      v108 = (v105->nGlyphs + 1) * (2 * (v105->locaFmt != 0) + 2);
      v109 = v104;
LABEL_99:
      FoFiTrueType::dumpString(v105, v109, v108, v125, v124);
      v105 = v122;
      goto LABEL_100;
    }
    if ( (_DWORD)v107 == 3 )
    {
      v109 = data;
      v108 = 54;
      goto LABEL_99;
    }
    v116 = v154[5 * v107];
    if ( v116 <= 0 )
      goto LABEL_100;
    v117 = FoFiTrueType::seekTable(v105, t42Tables[v107].tag);
    if ( v117 >= 0 )
    {
      v118 = v117;
      if ( FoFiBase::checkRegion(v105, v105->tables[v117].offset, v105->tables[v117].len) )
      {
        FoFiTrueType::dumpString(v105, &v105->file[v105->tables[v118].offset], v105->tables[v118].len, v125, v124);
        goto LABEL_100;
      }
    }
    if ( v107 == 9 && v123 )
    {
      if ( v116 >= 37 )
      {
        v105 = 0LL;
        error(ErrorCategory::errSyntaxWarning, -1LL, "length bigger than vheaTab size");
        v116 = 36;
      }
      v109 = (const unsigned __int8 *)&v137;
LABEL_125:
      v108 = v116;
      goto LABEL_99;
    }
    v105 = v122;
    if ( v107 == 10 && v123 )
    {
      if ( v116 > v128 )
      {
        v105 = 0LL;
        error(ErrorCategory::errSyntaxWarning, -1LL, "length bigger than vmtxTab size");
        v116 = v128;
      }
      v109 = (const unsigned __int8 *)v130;
      goto LABEL_125;
    }
LABEL_100:
    while ( 1 )
    {
      ++v107;
      v104 = v132;
      if ( v107 >= v78 )
        break;
      if ( (_DWORD)v107 != 2 )
        goto LABEL_102;
      v110 = v105->tables;
      v111 = FoFiTrueType::seekTable(v105, "glyf");
      v105 = v122;
      if ( v122->nGlyphs > 0 )
      {
        v112 = v110[v111].offset;
        v113 = v106;
        v114 = 0LL;
        do
        {
          if ( *v113 > 0 )
          {
            v115 = FoFiBase::checkRegion(v105, v112 + *(v113 - 2), *v113);
            v105 = v122;
            if ( v115 )
            {
              FoFiTrueType::dumpString(v122, &v122->file[v112 + *(v113 - 2)], *v113, v125, v124);
              v105 = v122;
            }
          }
          ++v114;
          v113 += 4;
        }
        while ( v114 < v105->nGlyphs );
      }
    }
  }
  v125(v124, "] def\n", 6);
  gfree(v104);
  gfree(p);
  if ( v130 )
    gfree(v130);
}
