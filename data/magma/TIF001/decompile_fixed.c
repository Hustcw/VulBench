int __fastcall horDiff16(TIFF *tif, uint8_t *cp0, tmsize_t cc)
{
  signed __int64 v3;
  int v4;
  signed __int64 v5;
  uint8_t *v6;
  __int64 v7;
  unsigned __int64 v8;
  unsigned __int64 v9;
  char v10;
  signed __int64 v11;
  uint8_t *v12;
  __int64 v13;
  __int64 v14;
  __int64 v15;
  __m128i v16;
  __m128i v17;
  __m128i v18;
  __m128i v19;
  __int64 v20;
  uint8_t *v21;
  __m128i v22;

  v3 = *((_QWORD *)tif->tif_data + 1);
  if ( cc % (2 * v3) )
  {
    v4 = 0;
    TIFFErrorExt(tif->tif_clientdata, "horDiff8", "%s", "(cc%(2*stride))!=0");
    return v4;
  }
  v4 = 1;
  v5 = cc / 2 - v3;
  if ( cc / 2 <= v3 )
    return v4;
  v6 = &cp0[2 * v5 - 2];
  v7 = v3 - 4;
  v8 = (unsigned __int64)(v3 - 20) >> 4;
  v9 = (v3 - 4) & 0xFFFFFFFFFFFFFFF0LL;
  if ( (unsigned __int64)v3 <= 4 )
    goto LABEL_11;
LABEL_12:
  if ( v7 <= 0 )
    goto LABEL_6;
  if ( (unsigned __int64)v7 < 0x10 )
  {
    v11 = v3 - 4;
    goto LABEL_21;
  }
  if ( !v8 )
  {
    v20 = 0LL;
LABEL_19:
    v21 = &v6[-2 * v20];
    v22 = _mm_sub_epi16(
            _mm_loadu_si128((const __m128i *)&v21[2 * v3 - 30]),
            _mm_loadu_si128((const __m128i *)(v21 - 30)));
    *(__m128i *)&v21[2 * v3 - 14] = _mm_sub_epi16(
                                      _mm_loadu_si128((const __m128i *)&v21[2 * v3 - 14]),
                                      _mm_loadu_si128((const __m128i *)(v21 - 14)));
    *(__m128i *)&v21[2 * v3 - 30] = v22;
    goto LABEL_20;
  }
  v12 = v6 - 14;
  v13 = (__int64)&v6[2 * v3 - 14];
  v14 = 0LL;
  v15 = v8 + 1 - (((_BYTE)v8 + 1) & 1);
  do
  {
    v16 = _mm_loadu_si128((const __m128i *)(v13 + 2 * v14 - 48));
    v17 = _mm_loadu_si128((const __m128i *)(v13 + 2 * v14 - 32));
    v18 = _mm_sub_epi16(
            _mm_loadu_si128((const __m128i *)(v13 + 2 * v14 - 16)),
            _mm_loadu_si128((const __m128i *)&v12[2 * v14 - 16]));
    *(__m128i *)(v13 + 2 * v14) = _mm_sub_epi16(
                                    _mm_loadu_si128((const __m128i *)(v13 + 2 * v14)),
                                    _mm_loadu_si128((const __m128i *)&v12[2 * v14]));
    *(__m128i *)(v13 + 2 * v14 - 16) = v18;
    v19 = _mm_sub_epi16(v16, _mm_loadu_si128((const __m128i *)&v12[2 * v14 - 48]));
    *(__m128i *)(v13 + 2 * v14 - 32) = _mm_sub_epi16(v17, _mm_loadu_si128((const __m128i *)&v12[2 * v14 - 32]));
    *(__m128i *)(v13 + 2 * v14 - 48) = v19;
    v14 -= 32LL;
    v15 -= 2LL;
  }
  while ( v15 );
  v20 = -v14;
  if ( (((_BYTE)v8 + 1) & 1) != 0 )
    goto LABEL_19;
LABEL_20:
  v6 -= 2 * ((v3 - 4) & 0xFFFFFFFFFFFFFFF0LL);
  v11 = v3 - 4 - v9;
  if ( v7 != v9 )
  {
    do
    {
LABEL_21:
      *(_WORD *)&v6[2 * v3] -= *(_WORD *)v6;
      v6 -= 2;
      v10 = (v11 - 1 < 0) ^ __OFADD__(-1LL, v11) | (v11 == 1);
      --v11;
    }
    while ( !v10 );
  }
LABEL_6:
  *(_WORD *)&v6[2 * v3] -= *(_WORD *)v6;
  v6 -= 2;
LABEL_7:
  *(_WORD *)&v6[2 * v3] -= *(_WORD *)v6;
  v6 -= 2;
LABEL_8:
  *(_WORD *)&v6[2 * v3] -= *(_WORD *)v6;
  v6 -= 2;
LABEL_9:
  *(_WORD *)&v6[2 * v3] -= *(_WORD *)v6;
  v6 -= 2;
  while ( 1 )
  {
    v10 = v5 <= v3;
    v5 -= v3;
    if ( v10 )
      return v4;
LABEL_11:
    switch ( v3 )
    {
      case 0LL:
        continue;
      case 1LL:
        goto LABEL_9;
      case 2LL:
        goto LABEL_8;
      case 3LL:
        goto LABEL_7;
      case 4LL:
        goto LABEL_6;
      default:
        goto LABEL_12;
    }
  }
}


int __fastcall horAcc32(TIFF *tif, uint8_t *cp0, tmsize_t cc)
{
  signed __int64 v3;
  int v4;
  signed __int64 v5;
  __int64 v6;
  unsigned __int64 v7;
  unsigned __int64 v8;
  char v9;
  signed __int64 v10;
  uint8_t *v11;
  __int64 v12;
  __int64 v13;
  __m128i v14;
  __m128i v15;
  __m128i v16;
  __m128i v17;
  __m128i v18;
  const __m128i *v19;
  __m128i v20;

  v3 = *((_QWORD *)tif->tif_data + 1);
  if ( cc % (4 * v3) )
  {
    v4 = 0;
    TIFFErrorExt(tif->tif_clientdata, "horAcc32", "%s", "cc%(4*stride))!=0");
    return v4;
  }
  v4 = 1;
  v5 = cc / 4 - v3;
  if ( cc / 4 <= v3 )
    return v4;
  v6 = v3 - 4;
  v7 = (unsigned __int64)(v3 - 12) >> 3;
  v8 = (v3 - 4) & 0xFFFFFFFFFFFFFFF8LL;
  if ( (unsigned __int64)v3 <= 4 )
    goto LABEL_11;
LABEL_12:
  if ( v6 <= 0 )
    goto LABEL_6;
  if ( (unsigned __int64)v6 < 8 )
  {
    v10 = v3 - 4;
    goto LABEL_21;
  }
  if ( !v7 )
  {
    v12 = 0LL;
LABEL_19:
    v19 = (const __m128i *)&cp0[4 * v12];
    v20 = _mm_add_epi32(_mm_loadu_si128((const __m128i *)((char *)v19 + 4 * v3 + 16)), _mm_loadu_si128(v19 + 1));
    *(const __m128i *)((char *)v19 + 4 * v3) = _mm_add_epi32(
                                                 _mm_loadu_si128((const __m128i *)((char *)v19 + 4 * v3)),
                                                 _mm_loadu_si128(v19));
    *(__m128i *)((char *)v19 + 4 * v3 + 16) = v20;
    goto LABEL_20;
  }
  v11 = &cp0[4 * v3 + 48];
  v12 = 0LL;
  v13 = v7 + 1 - (((_BYTE)v7 + 1) & 1);
  do
  {
    v14 = _mm_add_epi32(
            _mm_loadu_si128((const __m128i *)&v11[4 * v12 - 32]),
            _mm_loadu_si128((const __m128i *)&cp0[4 * v12 + 16]));
    v15 = _mm_loadu_si128((const __m128i *)&v11[4 * v12 - 16]);
    v16 = _mm_loadu_si128((const __m128i *)&v11[4 * v12]);
    *(__m128i *)&v11[4 * v12 - 48] = _mm_add_epi32(
                                       _mm_loadu_si128((const __m128i *)&v11[4 * v12 - 48]),
                                       _mm_loadu_si128((const __m128i *)&cp0[4 * v12]));
    *(__m128i *)&v11[4 * v12 - 32] = v14;
    v17 = _mm_add_epi32(_mm_loadu_si128((const __m128i *)&cp0[4 * v12 + 32]), v15);
    v18 = _mm_add_epi32(_mm_loadu_si128((const __m128i *)&cp0[4 * v12 + 48]), v16);
    *(__m128i *)&v11[4 * v12 - 16] = v17;
    *(__m128i *)&v11[4 * v12] = v18;
    v12 += 16LL;
    v13 -= 2LL;
  }
  while ( v13 );
  if ( (((_BYTE)v7 + 1) & 1) != 0 )
    goto LABEL_19;
LABEL_20:
  cp0 += 4 * v8;
  v10 = v3 - 4 - v8;
  if ( v6 != v8 )
  {
    do
    {
LABEL_21:
      *(_DWORD *)&cp0[4 * v3] += *(_DWORD *)cp0;
      cp0 += 4;
      v9 = (v10 - 1 < 0) ^ __OFADD__(-1LL, v10) | (v10 == 1);
      --v10;
    }
    while ( !v9 );
  }
LABEL_6:
  *(_DWORD *)&cp0[4 * v3] += *(_DWORD *)cp0;
  cp0 += 4;
LABEL_7:
  *(_DWORD *)&cp0[4 * v3] += *(_DWORD *)cp0;
  cp0 += 4;
LABEL_8:
  *(_DWORD *)&cp0[4 * v3] += *(_DWORD *)cp0;
  cp0 += 4;
LABEL_9:
  *(_DWORD *)&cp0[4 * v3] += *(_DWORD *)cp0;
  cp0 += 4;
  while ( 1 )
  {
    v9 = v5 <= v3;
    v5 -= v3;
    if ( v9 )
      return v4;
LABEL_11:
    switch ( v3 )
    {
      case 0LL:
        continue;
      case 1LL:
        goto LABEL_9;
      case 2LL:
        goto LABEL_8;
      case 3LL:
        goto LABEL_7;
      case 4LL:
        goto LABEL_6;
      default:
        goto LABEL_12;
    }
  }
}


int __fastcall fpDiff(TIFF *tif, uint8_t *cp0, tmsize_t cc)
{
  tmsize_t v3;
  signed __int64 v4;
  signed __int64 v5;
  tmsize_t v6;
  int v7;
  char *v10;
  char *v11;
  char *v12;
  __int64 v13;
  __int64 v14;
  int v15;
  unsigned int v16;
  uint8_t *v17;
  __int64 v18;
  unsigned __int64 v19;
  unsigned __int64 v20;
  signed __int64 v21;
  uint8_t *v22;
  __int64 v23;
  __int64 v24;
  __int64 v25;
  unsigned __int64 v26;
  unsigned __int64 v27;
  __int64 v28;
  uint8_t *v29;
  unsigned __int64 v30;
  char v31;

  v3 = cc;
  v4 = *((_QWORD *)tif->tif_data + 1);
  v5 = (unsigned __int64)tif->tif_dir.td_bitspersample >> 3;
  v6 = cc / v5;
  if ( cc % (v5 * v4) )
  {
    v7 = 0;
    TIFFErrorExt(tif->tif_clientdata, "fpDiff", "%s", "(cc%(bps*stride))!=0");
    return v7;
  }
  v10 = (char *)TIFFmalloc(cc);
  if ( !v10 )
    return 0;
  v11 = v10;
  TIFFmemcpy(v10, cp0, v3);
  if ( v6 > 0 )
  {
    v12 = v11 + 1;
    v13 = 0LL;
    if ( (_WORD)v5 )
      goto LABEL_9;
    while ( 1 )
    {
      do
      {
        ++v13;
        v12 += (unsigned __int16)v5;
        if ( v13 == v6 )
          goto LABEL_15;
      }
      while ( !(_WORD)v5 );
LABEL_9:
      if ( (_WORD)v5 == 1 )
        break;
      v16 = v5 - 2;
      v14 = 0LL;
      do
      {
        cp0[v13 + v6 * (v16 + 1)] = v12[v14 - 1];
        cp0[v13 + v6 * v16] = v12[v14];
        v14 += 2LL;
        v16 -= 2;
      }
      while ( (unsigned __int16)v5 - (unsigned __int64)(v5 & 1) != v14 );
      v15 = v14;
      if ( (v5 & 1) != 0 )
LABEL_14:
        cp0[v13 + v6 * (unsigned int)(v5 + ~v15)] = v11[v14 + v5 * v13];
    }
    v14 = 0LL;
    v15 = 0;
    goto LABEL_14;
  }
LABEL_15:
  TIFFfree(v11);
  v7 = 1;
  if ( v4 >= v3 )
    return v7;
  v17 = &cp0[v3 + ~v4];
  v18 = v4 - 4;
  v19 = (unsigned __int64)(v4 - 20) >> 4;
  v20 = (v4 - 4) & 0xFFFFFFFFFFFFFFF0LL;
  if ( (unsigned __int64)v4 <= 4 )
    goto LABEL_23;
LABEL_24:
  if ( v18 <= 0 )
    goto LABEL_18;
  if ( (unsigned __int64)v18 < 0x10 )
  {
    v21 = v4 - 4;
    goto LABEL_33;
  }
  if ( !v19 )
  {
    v28 = 0LL;
LABEL_31:
    v29 = &v17[-v28];
    v30 = _mm_sub_epi8(
            _mm_loadl_epi64((const __m128i *)&v17[v4 - v28 - 15]),
            _mm_loadl_epi64((const __m128i *)&v17[-v28 - 15])).m128i_u64[0];
    *(_QWORD *)&v29[v4 - 7] = _mm_sub_epi8(
                                _mm_loadl_epi64((const __m128i *)&v17[v4 - v28 - 7]),
                                _mm_loadl_epi64((const __m128i *)&v17[-v28 - 7])).m128i_u64[0];
    *(_QWORD *)&v29[v4 - 15] = v30;
    goto LABEL_32;
  }
  v22 = v17 - 7;
  v23 = (__int64)&v17[v4 - 7];
  v24 = 0LL;
  v25 = v19 + 1 - (((_BYTE)v19 + 1) & 1);
  do
  {
    v26 = _mm_sub_epi8(
            _mm_loadl_epi64((const __m128i *)(v23 + v24 - 8)),
            _mm_loadl_epi64((const __m128i *)&v22[v24 - 8])).m128i_u64[0];
    *(_QWORD *)(v23 + v24) = _mm_sub_epi8(
                               _mm_loadl_epi64((const __m128i *)(v23 + v24)),
                               _mm_loadl_epi64((const __m128i *)&v22[v24])).m128i_u64[0];
    *(_QWORD *)(v23 + v24 - 8) = v26;
    v27 = _mm_sub_epi8(
            _mm_loadl_epi64((const __m128i *)(v23 + v24 - 24)),
            _mm_loadl_epi64((const __m128i *)&v22[v24 - 24])).m128i_u64[0];
    *(_QWORD *)(v23 + v24 - 16) = _mm_sub_epi8(
                                    _mm_loadl_epi64((const __m128i *)(v23 + v24 - 16)),
                                    _mm_loadl_epi64((const __m128i *)&v22[v24 - 16])).m128i_u64[0];
    *(_QWORD *)(v23 + v24 - 24) = v27;
    v24 -= 32LL;
    v25 -= 2LL;
  }
  while ( v25 );
  v28 = -v24;
  if ( (((_BYTE)v19 + 1) & 1) != 0 )
    goto LABEL_31;
LABEL_32:
  v17 -= (v4 - 4) & 0xFFFFFFFFFFFFFFF0LL;
  v21 = v4 - 4 - v20;
  if ( v18 != v20 )
  {
    do
    {
LABEL_33:
      v17[v4] -= *v17;
      --v17;
      v31 = (v21 - 1 < 0) ^ __OFADD__(-1LL, v21) | (v21 == 1);
      --v21;
    }
    while ( !v31 );
  }
LABEL_18:
  v17[v4] -= *v17;
  --v17;
LABEL_19:
  v17[v4] -= *v17;
  --v17;
LABEL_20:
  v17[v4] -= *v17;
  --v17;
LABEL_21:
  v17[v4] -= *v17;
  --v17;
  while ( 1 )
  {
    v3 -= v4;
    if ( v3 <= v4 )
      return v7;
LABEL_23:
    switch ( v4 )
    {
      case 0LL:
        continue;
      case 1LL:
        goto LABEL_21;
      case 2LL:
        goto LABEL_20;
      case 3LL:
        goto LABEL_19;
      case 4LL:
        goto LABEL_18;
      default:
        goto LABEL_24;
    }
  }
}


int __fastcall horAcc8(TIFF *tif, uint8_t *cp0, tmsize_t cc)
{
  tmsize_t v3;
  int v4;
  tmsize_t v5;
  int v6;
  int v7;
  int v8;
  uint8_t *v9;
  char v10;
  tmsize_t v11;
  int v12;
  int v13;
  int v14;
  int v15;
  uint8_t *v16;
  int v17;
  int v18;
  int v19;
  int v20;
  tmsize_t v21;
  __int64 v22;
  unsigned __int64 v23;
  unsigned __int64 v24;
  unsigned __int64 v25;
  uint8_t *v26;
  uint8_t *v27;
  __int64 v28;
  __int64 v29;
  __m128i v30;
  __m128i v31;
  __m128i v32;
  __m128i v33;
  __m128i v34;
  uint8_t *v35;
  __m128i v36;

  v3 = *((_QWORD *)tif->tif_data + 1);
  if ( cc % v3 )
  {
    v4 = 0;
    TIFFErrorExt(tif->tif_clientdata, "horAcc8", "%s", "(cc%stride)!=0");
    return v4;
  }
  v4 = 1;
  if ( v3 >= cc )
    return v4;
  if ( v3 == 4 )
  {
    v11 = cc - 4;
    if ( !((cc - 4 < 0) ^ __OFADD__(-4LL, cc) | (cc == 4)) )
    {
      v12 = cp0[3];
      v13 = cp0[2];
      v14 = cp0[1];
      v15 = *cp0;
      if ( (((_BYTE)cc - 5) & 4) == 0 )
      {
        v15 += cp0[4];
        cp0[4] = v15;
        v14 += cp0[5];
        cp0[5] = v14;
        v13 += cp0[6];
        cp0[6] = v13;
        v12 += cp0[7];
        cp0[7] = v12;
        cp0 += 4;
        v11 = cc - 8;
      }
      if ( (unsigned __int64)(cc - 5) >= 4 )
      {
        v16 = cp0 + 11;
        do
        {
          v17 = v15 + *(v16 - 7);
          *(v16 - 7) += v15;
          v18 = v14 + *(v16 - 6);
          *(v16 - 6) += v14;
          v19 = v13 + *(v16 - 5);
          *(v16 - 5) += v13;
          v20 = v12 + *(v16 - 4);
          *(v16 - 4) += v12;
          v15 = v17 + *(v16 - 3);
          *(v16 - 3) += v17;
          v14 = v18 + *(v16 - 2);
          *(v16 - 2) += v18;
          v13 = v19 + *(v16 - 1);
          *(v16 - 1) += v19;
          v12 = v20 + *v16;
          *v16 += v20;
          v16 += 8;
          v10 = (v11 - 8 < 0) ^ __OFADD__(-8LL, v11) | (v11 == 8);
          v11 -= 8LL;
        }
        while ( !v10 );
      }
    }
    return v4;
  }
  if ( v3 == 3 )
  {
    v5 = cc - 3;
    if ( !((cc - 3 < 0) ^ __OFADD__(-3LL, cc) | (cc == 3)) )
    {
      v6 = cp0[2];
      v7 = cp0[1];
      v8 = *cp0;
      v9 = cp0 + 5;
      do
      {
        v8 += *(v9 - 2);
        *(v9 - 2) = v8;
        v7 += *(v9 - 1);
        *(v9 - 1) = v7;
        v6 += *v9;
        *v9 = v6;
        v9 += 3;
        v10 = (v5 - 3 < 0) ^ __OFADD__(-3LL, v5) | (v5 == 3);
        v5 -= 3LL;
      }
      while ( !v10 );
    }
    return v4;
  }
  v21 = cc - v3;
  v22 = v3 - 4;
  v23 = (unsigned __int64)(v3 - 36) >> 5;
  v24 = (v3 - 4) & 0xFFFFFFFFFFFFFFE0LL;
  if ( (unsigned __int64)v3 <= 4 )
    goto LABEL_24;
LABEL_25:
  if ( v22 <= 0 )
    goto LABEL_19;
  if ( (unsigned __int64)v22 < 0x20 )
  {
    v25 = v3 - 4;
    goto LABEL_34;
  }
  if ( !v23 )
  {
    v28 = 0LL;
LABEL_32:
    v35 = &cp0[v28];
    v36 = _mm_add_epi8(
            _mm_loadu_si128((const __m128i *)&cp0[v28 + 16]),
            _mm_loadu_si128((const __m128i *)&cp0[v28 + 16 + v3]));
    *(__m128i *)&v35[v3] = _mm_add_epi8(
                             _mm_loadu_si128((const __m128i *)&cp0[v28]),
                             _mm_loadu_si128((const __m128i *)&cp0[v28 + v3]));
    *(__m128i *)&v35[v3 + 16] = v36;
    goto LABEL_33;
  }
  v26 = cp0 + 48;
  v27 = &cp0[v3 + 48];
  v28 = 0LL;
  v29 = v23 + 1 - (((_BYTE)v23 + 1) & 1);
  do
  {
    v30 = _mm_add_epi8(
            _mm_loadu_si128((const __m128i *)&v27[v28 - 32]),
            _mm_loadu_si128((const __m128i *)&v26[v28 - 32]));
    v31 = _mm_loadu_si128((const __m128i *)&v27[v28 - 16]);
    v32 = _mm_loadu_si128((const __m128i *)&v27[v28]);
    *(__m128i *)&cp0[v3 + v28] = _mm_add_epi8(
                                   _mm_loadu_si128((const __m128i *)&cp0[v3 + v28]),
                                   _mm_loadu_si128((const __m128i *)&cp0[v28]));
    *(__m128i *)&v27[v28 - 32] = v30;
    v33 = _mm_add_epi8(_mm_loadu_si128((const __m128i *)&v26[v28 - 16]), v31);
    v34 = _mm_add_epi8(_mm_loadu_si128((const __m128i *)&v26[v28]), v32);
    *(__m128i *)&v27[v28 - 16] = v33;
    *(__m128i *)&v27[v28] = v34;
    v28 += 64LL;
    v29 -= 2LL;
  }
  while ( v29 );
  if ( (((_BYTE)v23 + 1) & 1) != 0 )
    goto LABEL_32;
LABEL_33:
  cp0 += v24;
  v25 = v3 - 4 - v24;
  if ( v22 != v24 )
  {
    do
    {
LABEL_34:
      cp0[v3] += *cp0;
      ++cp0;
      v10 = ((__int64)(v25 - 1) < 0) ^ __OFADD__(-1LL, v25) | (v25 == 1);
      --v25;
    }
    while ( !v10 );
  }
LABEL_19:
  cp0[v3] += *cp0;
  ++cp0;
LABEL_20:
  cp0[v3] += *cp0;
  ++cp0;
LABEL_21:
  cp0[v3] += *cp0;
  ++cp0;
LABEL_22:
  cp0[v3] += *cp0;
  ++cp0;
  while ( 1 )
  {
    v10 = v21 <= v3;
    v21 -= v3;
    if ( v10 )
      return v4;
LABEL_24:
    switch ( v3 )
    {
      case 0LL:
        continue;
      case 1LL:
        goto LABEL_22;
      case 2LL:
        goto LABEL_21;
      case 3LL:
        goto LABEL_20;
      case 4LL:
        goto LABEL_19;
      default:
        goto LABEL_25;
    }
  }
}


int __fastcall PredictorDecodeTile(TIFF *tif, uint8_t *op0, tmsize_t occ0, uint16_t s)
{
  uint8_t *tif_data;
  unsigned int (__fastcall *v5)(TIFF *, uint8_t *, tmsize_t, _QWORD);
  tmsize_t v6;
  int v7;
  __int64 v8;
  unsigned int (__fastcall *v9)(TIFF *, uint8_t *, _QWORD);
  uint8_t *v10;
  bool v11;
  uint8_t *v12;

  tif_data = tif->tif_data;
  if ( !tif_data )
    __assert_fail(
      "sp != NULL",
      "tif_predict.c",
      0x1F7u,
      "int PredictorDecodeTile(TIFF *, uint8_t *, tmsize_t, uint16_t)");
  v5 = (unsigned int (__fastcall *)(TIFF *, uint8_t *, tmsize_t, _QWORD))*((_QWORD *)tif_data + 9);
  if ( !v5 )
    __assert_fail(
      "sp->decodetile != NULL",
      "tif_predict.c",
      0x1F8u,
      "int PredictorDecodeTile(TIFF *, uint8_t *, tmsize_t, uint16_t)");
  v6 = occ0;
  v7 = 0;
  if ( v5(tif, op0, occ0, s) )
  {
    v8 = *((_QWORD *)tif_data + 2);
    if ( v8 <= 0 )
      __assert_fail(
        "rowsize > 0",
        "tif_predict.c",
        0x1FCu,
        "int PredictorDecodeTile(TIFF *, uint8_t *, tmsize_t, uint16_t)");
    if ( !(v6 % v8) )
    {
      v9 = (unsigned int (__fastcall *)(TIFF *, uint8_t *, _QWORD))*((_QWORD *)tif_data + 10);
      if ( !v9 )
        __assert_fail(
          "sp->decodepfunc != NULL",
          "tif_predict.c",
          0x20Au,
          "int PredictorDecodeTile(TIFF *, uint8_t *, tmsize_t, uint16_t)");
      if ( v6 > 0 )
      {
        if ( !v9(tif, op0, *((_QWORD *)tif_data + 2)) )
          return v7;
        v10 = &op0[v8];
        while ( 1 )
        {
          v11 = v6 <= v8;
          v6 -= v8;
          if ( v11 )
            break;
          v12 = v10;
          v10 += v8;
          if ( !(*((unsigned int (__fastcall **)(TIFF *, uint8_t *, __int64))tif_data + 10))(tif, v12, v8) )
            return v7;
        }
      }
      return 1;
    }
    v7 = 0;
    TIFFErrorExt(tif->tif_clientdata, "PredictorDecodeTile", "%s", "occ0%rowsize != 0");
  }
  return v7;
}


int __fastcall horDiff32(TIFF *tif, uint8_t *cp0, tmsize_t cc)
{
  signed __int64 v3;
  int v4;
  signed __int64 v5;
  uint8_t *v6;
  __int64 v7;
  unsigned __int64 v8;
  unsigned __int64 v9;
  char v10;
  signed __int64 v11;
  uint8_t *v12;
  __int64 v13;
  __int64 v14;
  __m128i v15;
  __m128i v16;
  __m128i v17;
  __m128i v18;
  __int64 v19;
  uint8_t *v20;
  __m128i v21;

  v3 = *((_QWORD *)tif->tif_data + 1);
  if ( cc % (4 * v3) )
  {
    v4 = 0;
    TIFFErrorExt(tif->tif_clientdata, "horDiff32", "%s", "(cc%(4*stride))!=0");
    return v4;
  }
  v4 = 1;
  v5 = cc / 4 - v3;
  if ( cc / 4 <= v3 )
    return v4;
  v6 = &cp0[4 * v5 - 4];
  v7 = v3 - 4;
  v8 = (unsigned __int64)(v3 - 12) >> 3;
  v9 = (v3 - 4) & 0xFFFFFFFFFFFFFFF8LL;
  if ( (unsigned __int64)v3 <= 4 )
    goto LABEL_11;
LABEL_12:
  if ( v7 <= 0 )
    goto LABEL_6;
  if ( (unsigned __int64)v7 < 8 )
  {
    v11 = v3 - 4;
    goto LABEL_21;
  }
  if ( !v8 )
  {
    v19 = 0LL;
LABEL_19:
    v20 = &v6[-4 * v19];
    v21 = _mm_sub_epi32(
            _mm_loadu_si128((const __m128i *)&v20[4 * v3 - 28]),
            _mm_loadu_si128((const __m128i *)(v20 - 28)));
    *(__m128i *)&v20[4 * v3 - 12] = _mm_sub_epi32(
                                      _mm_loadu_si128((const __m128i *)&v20[4 * v3 - 12]),
                                      _mm_loadu_si128((const __m128i *)(v20 - 12)));
    *(__m128i *)&v20[4 * v3 - 28] = v21;
    goto LABEL_20;
  }
  v12 = &v6[4 * v3 - 12];
  v13 = 0LL;
  v14 = v8 + 1 - (((_BYTE)v8 + 1) & 1);
  do
  {
    v15 = _mm_loadu_si128((const __m128i *)&v12[4 * v13 - 48]);
    v16 = _mm_loadu_si128((const __m128i *)&v12[4 * v13 - 32]);
    v17 = _mm_sub_epi32(
            _mm_loadu_si128((const __m128i *)&v12[4 * v13 - 16]),
            _mm_loadu_si128((const __m128i *)&v6[4 * v13 - 28]));
    *(__m128i *)&v12[4 * v13] = _mm_sub_epi32(
                                  _mm_loadu_si128((const __m128i *)&v12[4 * v13]),
                                  _mm_loadu_si128((const __m128i *)&v6[4 * v13 - 12]));
    *(__m128i *)&v12[4 * v13 - 16] = v17;
    v18 = _mm_sub_epi32(v15, _mm_loadu_si128((const __m128i *)&v6[4 * v13 - 60]));
    *(__m128i *)&v12[4 * v13 - 32] = _mm_sub_epi32(v16, _mm_loadu_si128((const __m128i *)&v6[4 * v13 - 44]));
    *(__m128i *)&v12[4 * v13 - 48] = v18;
    v13 -= 16LL;
    v14 -= 2LL;
  }
  while ( v14 );
  v19 = -v13;
  if ( (((_BYTE)v8 + 1) & 1) != 0 )
    goto LABEL_19;
LABEL_20:
  v6 -= 4 * ((v3 - 4) & 0xFFFFFFFFFFFFFFF8LL);
  v11 = v3 - 4 - v9;
  if ( v7 != v9 )
  {
    do
    {
LABEL_21:
      *(_DWORD *)&v6[4 * v3] -= *(_DWORD *)v6;
      v6 -= 4;
      v10 = (v11 - 1 < 0) ^ __OFADD__(-1LL, v11) | (v11 == 1);
      --v11;
    }
    while ( !v10 );
  }
LABEL_6:
  *(_DWORD *)&v6[4 * v3] -= *(_DWORD *)v6;
  v6 -= 4;
LABEL_7:
  *(_DWORD *)&v6[4 * v3] -= *(_DWORD *)v6;
  v6 -= 4;
LABEL_8:
  *(_DWORD *)&v6[4 * v3] -= *(_DWORD *)v6;
  v6 -= 4;
LABEL_9:
  *(_DWORD *)&v6[4 * v3] -= *(_DWORD *)v6;
  v6 -= 4;
  while ( 1 )
  {
    v10 = v5 <= v3;
    v5 -= v3;
    if ( v10 )
      return v4;
LABEL_11:
    switch ( v3 )
    {
      case 0LL:
        continue;
      case 1LL:
        goto LABEL_9;
      case 2LL:
        goto LABEL_8;
      case 3LL:
        goto LABEL_7;
      case 4LL:
        goto LABEL_6;
      default:
        goto LABEL_12;
    }
  }
}


int __fastcall fpAcc(TIFF *tif, uint8_t *cp0, tmsize_t cc)
{
  tmsize_t v4;
  signed __int64 v5;
  tmsize_t v6;
  int v7;
  void *v9;
  void *v10;
  __int64 v11;
  unsigned __int64 v12;
  uint8_t *v13;
  tmsize_t v14;
  unsigned __int64 v15;
  uint8_t *v16;
  __int64 v17;
  __int64 v18;
  __int64 v19;
  __m128i v20;
  __m128i v21;
  __m128i v22;
  __m128i v23;
  __m128i v24;
  unsigned __int64 v25;
  uint8_t *v26;
  __m128i v27;
  char v28;
  uint8_t *v29;
  __int64 v30;
  __int64 v31;
  int v32;
  unsigned int v33;
  __int64 v35;
  __int64 v36;
  unsigned __int64 v37;

  v4 = *((_QWORD *)tif->tif_data + 1);
  v5 = (unsigned __int64)tif->tif_dir.td_bitspersample >> 3;
  v6 = cc / v5;
  if ( !(cc % (v5 * v4)) )
  {
    v9 = TIFFmalloc(cc);
    if ( !v9 )
      return 0;
    v10 = v9;
    if ( v4 >= cc )
      goto LABEL_26;
    v11 = v4 - 4;
    v12 = (unsigned __int64)(v4 - 36) >> 5;
    v37 = (v4 - 4) & 0xFFFFFFFFFFFFFFE0LL;
    v36 = ((_BYTE)v12 + 1) & 1;
    v35 = v12 + 1 - v36;
    v13 = cp0;
    v14 = cc;
    if ( (unsigned __int64)v4 <= 4 )
      goto LABEL_12;
LABEL_13:
    if ( v11 <= 0 )
      goto LABEL_7;
    if ( (unsigned __int64)v11 < 0x20 )
    {
      v15 = v4 - 4;
      goto LABEL_22;
    }
    if ( v12 )
    {
      v16 = v13 + 48;
      v17 = (__int64)&v13[v4 + 48];
      v18 = 0LL;
      v19 = v35;
      do
      {
        v20 = _mm_add_epi8(
                _mm_loadu_si128((const __m128i *)(v17 + v18 - 32)),
                _mm_loadu_si128((const __m128i *)&v16[v18 - 32]));
        v21 = _mm_loadu_si128((const __m128i *)(v17 + v18 - 16));
        v22 = _mm_loadu_si128((const __m128i *)(v17 + v18));
        *(__m128i *)&v13[v4 + v18] = _mm_add_epi8(
                                       _mm_loadu_si128((const __m128i *)&v13[v4 + v18]),
                                       _mm_loadu_si128((const __m128i *)&v13[v18]));
        *(__m128i *)(v17 + v18 - 32) = v20;
        v23 = _mm_add_epi8(_mm_loadu_si128((const __m128i *)&v16[v18 - 16]), v21);
        v24 = _mm_add_epi8(_mm_loadu_si128((const __m128i *)&v16[v18]), v22);
        *(__m128i *)(v17 + v18 - 16) = v23;
        *(__m128i *)(v17 + v18) = v24;
        v18 += 64LL;
        v19 -= 2LL;
      }
      while ( v19 );
      if ( v36 )
        goto LABEL_20;
    }
    else
    {
      v18 = 0LL;
      if ( v36 )
      {
LABEL_20:
        v25 = v12;
        v26 = &v13[v18];
        v27 = _mm_add_epi8(
                _mm_loadu_si128((const __m128i *)&v13[v18 + 16]),
                _mm_loadu_si128((const __m128i *)&v13[v18 + 16 + v4]));
        *(__m128i *)&v26[v4] = _mm_add_epi8(
                                 _mm_loadu_si128((const __m128i *)&v13[v18]),
                                 _mm_loadu_si128((const __m128i *)&v13[v18 + v4]));
        *(__m128i *)&v26[v4 + 16] = v27;
        v12 = v25;
      }
    }
    v13 += v37;
    v15 = v4 - 4 - v37;
    if ( v11 != v37 )
    {
      do
      {
LABEL_22:
        v13[v4] += *v13;
        ++v13;
        v28 = ((__int64)(v15 - 1) < 0) ^ __OFADD__(-1LL, v15) | (v15 == 1);
        --v15;
      }
      while ( !v28 );
    }
LABEL_7:
    v13[v4] += *v13;
    ++v13;
LABEL_8:
    v13[v4] += *v13;
    ++v13;
LABEL_9:
    v13[v4] += *v13;
    ++v13;
LABEL_10:
    v13[v4] += *v13;
    ++v13;
    while ( 1 )
    {
      v14 -= v4;
      if ( v14 <= v4 )
        break;
LABEL_12:
      switch ( v4 )
      {
        case 0LL:
          continue;
        case 1LL:
          goto LABEL_10;
        case 2LL:
          goto LABEL_9;
        case 3LL:
          goto LABEL_8;
        case 4LL:
          goto LABEL_7;
        default:
          goto LABEL_13;
      }
    }
LABEL_26:
    TIFFmemcpy(v10, cp0, cc);
    if ( v6 <= 0 )
    {
LABEL_36:
      TIFFfree(v10);
      return 1;
    }
    v29 = cp0 + 1;
    v30 = 0LL;
    if ( (_WORD)v5 )
      goto LABEL_30;
    while ( 1 )
    {
      do
      {
        ++v30;
        v29 += (unsigned __int16)v5;
        if ( v30 == v6 )
          goto LABEL_36;
      }
      while ( !(_WORD)v5 );
LABEL_30:
      if ( (_WORD)v5 == 1 )
        break;
      v33 = v5 - 2;
      v31 = 0LL;
      do
      {
        v29[v31 - 1] = *((_BYTE *)v10 + v30 + v6 * (v33 + 1));
        v29[v31] = *((_BYTE *)v10 + v30 + v6 * v33);
        v31 += 2LL;
        v33 -= 2;
      }
      while ( (unsigned __int16)v5 - (unsigned __int64)(v5 & 1) != v31 );
      v32 = v31;
      if ( (v5 & 1) != 0 )
LABEL_35:
        cp0[v31 + v5 * v30] = *((_BYTE *)v10 + v30 + v6 * (unsigned int)(v5 + ~v32));
    }
    v31 = 0LL;
    v32 = 0;
    goto LABEL_35;
  }
  v7 = 0;
  TIFFErrorExt(tif->tif_clientdata, "fpAcc", "%s", "cc%(bps*stride))!=0");
  return v7;
}


int __fastcall horAcc16(TIFF *tif, uint8_t *cp0, tmsize_t cc)
{
  signed __int64 v3;
  __int64 v4;
  int v5;
  signed __int64 v6;
  __int64 v7;
  unsigned __int64 v8;
  unsigned __int64 v9;
  char v10;
  signed __int64 v11;
  uint8_t *v12;
  uint8_t *v13;
  __int64 v14;
  __int64 v15;
  __m128i v16;
  __m128i v17;
  __m128i v18;
  __m128i v19;
  __m128i v20;
  const __m128i *v21;
  __m128i v22;

  v3 = *((_QWORD *)tif->tif_data + 1);
  v4 = 2 * v3;
  if ( cc % (2 * v3) )
  {
    v5 = 0;
    TIFFErrorExt(tif->tif_clientdata, "horAcc16", "%s", "cc%(2*stride))!=0");
    return v5;
  }
  v5 = 1;
  v6 = cc / 2 - v3;
  if ( cc / 2 <= v3 )
    return v5;
  v7 = v3 - 4;
  v8 = (unsigned __int64)(v3 - 20) >> 4;
  v9 = (v3 - 4) & 0xFFFFFFFFFFFFFFF0LL;
  if ( (unsigned __int64)v3 <= 4 )
    goto LABEL_11;
LABEL_12:
  if ( v7 <= 0 )
    goto LABEL_6;
  if ( (unsigned __int64)v7 < 0x10 )
  {
    v11 = v3 - 4;
    goto LABEL_21;
  }
  if ( !v8 )
  {
    v14 = 0LL;
LABEL_19:
    v21 = (const __m128i *)&cp0[2 * v14];
    v22 = _mm_add_epi16(_mm_loadu_si128(v21 + 1), _mm_loadu_si128((const __m128i *)((char *)v21 + 2 * v3 + 16)));
    *(const __m128i *)((char *)v21 + 2 * v3) = _mm_add_epi16(
                                                 _mm_loadu_si128(v21),
                                                 _mm_loadu_si128((const __m128i *)((char *)v21 + 2 * v3)));
    *(__m128i *)((char *)v21 + 2 * v3 + 16) = v22;
    goto LABEL_20;
  }
  v12 = cp0 + 48;
  v13 = &cp0[v4 + 48];
  v14 = 0LL;
  v15 = v8 + 1 - (((_BYTE)v8 + 1) & 1);
  do
  {
    v16 = _mm_add_epi16(
            _mm_loadu_si128((const __m128i *)&v13[2 * v14 - 32]),
            _mm_loadu_si128((const __m128i *)&v12[2 * v14 - 32]));
    v17 = _mm_loadu_si128((const __m128i *)&v13[2 * v14 - 16]);
    v18 = _mm_loadu_si128((const __m128i *)&v13[2 * v14]);
    *(__m128i *)&cp0[2 * v14 + v4] = _mm_add_epi16(
                                       _mm_loadu_si128((const __m128i *)&cp0[2 * v14 + v4]),
                                       _mm_loadu_si128((const __m128i *)&cp0[2 * v14]));
    *(__m128i *)&v13[2 * v14 - 32] = v16;
    v19 = _mm_add_epi16(_mm_loadu_si128((const __m128i *)&v12[2 * v14 - 16]), v17);
    v20 = _mm_add_epi16(_mm_loadu_si128((const __m128i *)&v12[2 * v14]), v18);
    *(__m128i *)&v13[2 * v14 - 16] = v19;
    *(__m128i *)&v13[2 * v14] = v20;
    v14 += 32LL;
    v15 -= 2LL;
  }
  while ( v15 );
  if ( (((_BYTE)v8 + 1) & 1) != 0 )
    goto LABEL_19;
LABEL_20:
  cp0 += 2 * v9;
  v11 = v3 - 4 - v9;
  if ( v7 != v9 )
  {
    do
    {
LABEL_21:
      *(_WORD *)&cp0[2 * v3] += *(_WORD *)cp0;
      cp0 += 2;
      v10 = (v11 - 1 < 0) ^ __OFADD__(-1LL, v11) | (v11 == 1);
      --v11;
    }
    while ( !v10 );
  }
LABEL_6:
  *(_WORD *)&cp0[2 * v3] += *(_WORD *)cp0;
  cp0 += 2;
LABEL_7:
  *(_WORD *)&cp0[2 * v3] += *(_WORD *)cp0;
  cp0 += 2;
LABEL_8:
  *(_WORD *)&cp0[2 * v3] += *(_WORD *)cp0;
  cp0 += 2;
LABEL_9:
  *(_WORD *)&cp0[2 * v3] += *(_WORD *)cp0;
  cp0 += 2;
  while ( 1 )
  {
    v10 = v6 <= v3;
    v6 -= v3;
    if ( v10 )
      return v5;
LABEL_11:
    switch ( v3 )
    {
      case 0LL:
        continue;
      case 1LL:
        goto LABEL_9;
      case 2LL:
        goto LABEL_8;
      case 3LL:
        goto LABEL_7;
      case 4LL:
        goto LABEL_6;
      default:
        goto LABEL_12;
    }
  }
}


int __fastcall PredictorEncodeTile(TIFF *tif, uint8_t *bp0, tmsize_t cc0, uint16_t s)
{
  uint8_t *tif_data;
  char *v7;
  char *v8;
  __int64 v9;
  tmsize_t v11;
  bool v12;
  int v13;
  uint16_t v14;
  char *p;

  tif_data = tif->tif_data;
  if ( !tif_data )
    __assert_fail(
      "sp != NULL",
      "tif_predict.c",
      0x2F7u,
      "int PredictorEncodeTile(TIFF *, uint8_t *, tmsize_t, uint16_t)");
  if ( !*((_QWORD *)tif_data + 6) )
    __assert_fail(
      "sp->encodepfunc != NULL",
      "tif_predict.c",
      0x2F8u,
      "int PredictorEncodeTile(TIFF *, uint8_t *, tmsize_t, uint16_t)");
  if ( !*((_QWORD *)tif_data + 5) )
    __assert_fail(
      "sp->encodetile != NULL",
      "tif_predict.c",
      0x2F9u,
      "int PredictorEncodeTile(TIFF *, uint8_t *, tmsize_t, uint16_t)");
  v7 = (char *)TIFFmalloc(cc0);
  if ( !v7 )
  {
    TIFFErrorExt(tif->tif_clientdata, "PredictorEncodeTile", "Out of memory allocating %ld byte temp buffer.", cc0);
    return 0;
  }
  v8 = v7;
  v14 = s;
  memcpy(v7, bp0, cc0);
  v9 = *((_QWORD *)tif_data + 2);
  if ( v9 <= 0 )
    __assert_fail(
      "rowsize > 0",
      "tif_predict.c",
      0x30Bu,
      "int PredictorEncodeTile(TIFF *, uint8_t *, tmsize_t, uint16_t)");
  if ( cc0 % v9 )
  {
    TIFFErrorExt(tif->tif_clientdata, "PredictorEncodeTile", "%s", "(cc0%rowsize)!=0");
    TIFFfree(v8);
    return 0;
  }
  p = v8;
  if ( cc0 > 0 )
  {
    v11 = cc0;
    do
    {
      (*((void (__fastcall **)(TIFF *, char *, __int64))tif_data + 6))(tif, v8, v9);
      v8 += v9;
      v12 = v11 <= v9;
      v11 -= v9;
    }
    while ( !v12 );
  }
  v13 = (*((__int64 (__fastcall **)(TIFF *, char *, tmsize_t, _QWORD))tif_data + 5))(tif, p, cc0, v14);
  TIFFfree(p);
  return v13;
}


int __fastcall horDiff8(TIFF *tif, uint8_t *cp0, tmsize_t cc)
{
  tmsize_t v3;
  int v4;
  tmsize_t v5;
  uint8_t v6;
  uint8_t v7;
  uint8_t v8;
  uint8_t *v9;
  uint8_t v10;
  uint8_t v11;
  uint8_t v12;
  char v13;
  uint8_t v14;
  uint8_t v15;
  uint8_t v16;
  uint8_t v17;
  uint8_t *v18;
  uint8_t v19;
  uint8_t v20;
  uint8_t v21;
  uint8_t v22;
  uint8_t *v23;
  __int64 v24;
  unsigned __int64 v25;
  unsigned __int64 v26;
  unsigned __int64 v27;
  tmsize_t v28;
  unsigned __int64 v29;
  uint8_t *v30;
  __int64 v31;
  __int64 v32;
  __int64 v33;
  unsigned __int64 v34;
  unsigned __int64 v35;
  __int64 v36;
  uint8_t *v37;
  unsigned __int64 v38;

  v3 = *((_QWORD *)tif->tif_data + 1);
  if ( cc % v3 )
  {
    v4 = 0;
    TIFFErrorExt(tif->tif_clientdata, "horDiff8", "%s", "(cc%stride)!=0");
    return v4;
  }
  v4 = 1;
  if ( v3 >= cc )
    return v4;
  v5 = cc - v3;
  if ( v3 == 4 )
  {
    v14 = *cp0;
    v15 = cp0[1];
    v16 = cp0[2];
    v17 = cp0[3];
    v18 = cp0 + 7;
    do
    {
      v19 = *(v18 - 3);
      v20 = *(v18 - 2);
      *(v18 - 3) = v19 - v14;
      *(v18 - 2) = v20 - v15;
      v21 = *(v18 - 1);
      *(v18 - 1) = v21 - v16;
      v22 = *v18;
      *v18 -= v17;
      v18 += 4;
      v14 = v19;
      v15 = v20;
      v16 = v21;
      v17 = v22;
      v13 = (v5 - 4 < 0) ^ __OFADD__(-4LL, v5) | (v5 == 4);
      v5 -= 4LL;
    }
    while ( !v13 );
    return v4;
  }
  if ( v3 == 3 )
  {
    v6 = *cp0;
    v7 = cp0[1];
    v8 = cp0[2];
    v9 = cp0 + 5;
    do
    {
      v10 = *(v9 - 2);
      v11 = *(v9 - 1);
      *(v9 - 2) = v10 - v6;
      *(v9 - 1) = v11 - v7;
      v12 = *v9;
      *v9 -= v8;
      v9 += 3;
      v6 = v10;
      v7 = v11;
      v8 = v12;
      v13 = (v5 - 3 < 0) ^ __OFADD__(-3LL, v5) | (v5 == 3);
      v5 -= 3LL;
    }
    while ( !v13 );
    return v4;
  }
  v23 = &cp0[v5 - 1];
  v24 = v3 - 4;
  v25 = (unsigned __int64)(v3 - 20) >> 4;
  v26 = (v3 - 4) & 0xFFFFFFFFFFFFFFF0LL;
  v27 = v3 - 4 - v26;
  if ( (unsigned __int64)v3 <= 4 )
    goto LABEL_19;
LABEL_20:
  if ( v24 <= 0 )
    goto LABEL_14;
  if ( (unsigned __int64)v24 < 0x10 )
  {
    v28 = v3 - 4;
    goto LABEL_29;
  }
  if ( !v25 )
  {
    v36 = 0LL;
LABEL_27:
    v37 = &v23[-v36];
    v38 = _mm_sub_epi8(
            _mm_loadl_epi64((const __m128i *)&v23[v3 - v36 - 15]),
            _mm_loadl_epi64((const __m128i *)&v23[-v36 - 15])).m128i_u64[0];
    *(_QWORD *)&v37[v3 - 7] = _mm_sub_epi8(
                                _mm_loadl_epi64((const __m128i *)&v23[v3 - v36 - 7]),
                                _mm_loadl_epi64((const __m128i *)&v23[-v36 - 7])).m128i_u64[0];
    *(_QWORD *)&v37[v3 - 15] = v38;
    goto LABEL_28;
  }
  v29 = v27;
  v30 = v23 - 7;
  v31 = (__int64)&v23[v3 - 7];
  v32 = 0LL;
  v33 = v25 + 1 - (((_BYTE)v25 + 1) & 1);
  do
  {
    v34 = _mm_sub_epi8(
            _mm_loadl_epi64((const __m128i *)(v31 + v32 - 8)),
            _mm_loadl_epi64((const __m128i *)&v30[v32 - 8])).m128i_u64[0];
    *(_QWORD *)(v31 + v32) = _mm_sub_epi8(
                               _mm_loadl_epi64((const __m128i *)(v31 + v32)),
                               _mm_loadl_epi64((const __m128i *)&v30[v32])).m128i_u64[0];
    *(_QWORD *)(v31 + v32 - 8) = v34;
    v35 = _mm_sub_epi8(
            _mm_loadl_epi64((const __m128i *)(v31 + v32 - 24)),
            _mm_loadl_epi64((const __m128i *)&v30[v32 - 24])).m128i_u64[0];
    *(_QWORD *)(v31 + v32 - 16) = _mm_sub_epi8(
                                    _mm_loadl_epi64((const __m128i *)(v31 + v32 - 16)),
                                    _mm_loadl_epi64((const __m128i *)&v30[v32 - 16])).m128i_u64[0];
    *(_QWORD *)(v31 + v32 - 24) = v35;
    v32 -= 32LL;
    v33 -= 2LL;
  }
  while ( v33 );
  v36 = -v32;
  v27 = v29;
  if ( (((_BYTE)v25 + 1) & 1) != 0 )
    goto LABEL_27;
LABEL_28:
  v23 -= (v3 - 4) & 0xFFFFFFFFFFFFFFF0LL;
  v28 = v27;
  if ( v24 != v26 )
  {
    do
    {
LABEL_29:
      v23[v3] -= *v23;
      --v23;
      v13 = (v28 - 1 < 0) ^ __OFADD__(-1LL, v28) | (v28 == 1);
      --v28;
    }
    while ( !v13 );
  }
LABEL_14:
  v23[v3] -= *v23;
  --v23;
LABEL_15:
  v23[v3] -= *v23;
  --v23;
LABEL_16:
  v23[v3] -= *v23;
  --v23;
LABEL_17:
  v23[v3] -= *v23;
  --v23;
  while ( 1 )
  {
    v13 = v5 <= v3;
    v5 -= v3;
    if ( v13 )
      return v4;
LABEL_19:
    switch ( v3 )
    {
      case 0LL:
        continue;
      case 1LL:
        goto LABEL_17;
      case 2LL:
        goto LABEL_16;
      case 3LL:
        goto LABEL_15;
      case 4LL:
        goto LABEL_14;
      default:
        goto LABEL_20;
    }
  }
}
