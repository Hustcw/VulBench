int __fastcall horDiff16(TIFF *tif, uint8_t *cp0, tmsize_t cc)
{
  signed __int64 v3;
  signed __int64 v4;
  uint8_t *v5;
  __int64 v6;
  unsigned __int64 v7;
  unsigned __int64 v8;
  char v9;
  signed __int64 v10;
  uint8_t *v11;
  __int64 v12;
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
  v4 = cc / 2 - v3;
  if ( cc / 2 <= v3 )
    return 1;
  v5 = &cp0[2 * v4 - 2];
  v6 = v3 - 4;
  v7 = (unsigned __int64)(v3 - 20) >> 4;
  v8 = (v3 - 4) & 0xFFFFFFFFFFFFFFF0LL;
  if ( (unsigned __int64)v3 <= 4 )
    goto LABEL_9;
LABEL_10:
  if ( v6 > 0 )
  {
    if ( (unsigned __int64)v6 < 0x10 )
    {
      v10 = v3 - 4;
      do
      {
LABEL_19:
        *(_WORD *)&v5[2 * v3] -= *(_WORD *)v5;
        v5 -= 2;
        v9 = (v10 - 1 < 0) ^ __OFADD__(-1LL, v10) | (v10 == 1);
        --v10;
      }
      while ( !v9 );
      goto LABEL_4;
    }
    if ( v7 )
    {
      v11 = v5 - 14;
      v12 = (__int64)&v5[2 * v3 - 14];
      v13 = 0LL;
      v14 = v7 + 1 - (((_BYTE)v7 + 1) & 1);
      do
      {
        v15 = _mm_loadu_si128((const __m128i *)(v12 + 2 * v13 - 48));
        v16 = _mm_loadu_si128((const __m128i *)(v12 + 2 * v13 - 32));
        v17 = _mm_sub_epi16(
                _mm_loadu_si128((const __m128i *)(v12 + 2 * v13 - 16)),
                _mm_loadu_si128((const __m128i *)&v11[2 * v13 - 16]));
        *(__m128i *)(v12 + 2 * v13) = _mm_sub_epi16(
                                        _mm_loadu_si128((const __m128i *)(v12 + 2 * v13)),
                                        _mm_loadu_si128((const __m128i *)&v11[2 * v13]));
        *(__m128i *)(v12 + 2 * v13 - 16) = v17;
        v18 = _mm_sub_epi16(v15, _mm_loadu_si128((const __m128i *)&v11[2 * v13 - 48]));
        *(__m128i *)(v12 + 2 * v13 - 32) = _mm_sub_epi16(v16, _mm_loadu_si128((const __m128i *)&v11[2 * v13 - 32]));
        *(__m128i *)(v12 + 2 * v13 - 48) = v18;
        v13 -= 32LL;
        v14 -= 2LL;
      }
      while ( v14 );
      v19 = -v13;
      if ( (((_BYTE)v7 + 1) & 1) == 0 )
      {
LABEL_18:
        v5 -= 2 * ((v3 - 4) & 0xFFFFFFFFFFFFFFF0LL);
        v10 = v3 - 4 - v8;
        if ( v6 == v8 )
          goto LABEL_4;
        goto LABEL_19;
      }
    }
    else
    {
      v19 = 0LL;
    }
    v20 = &v5[-2 * v19];
    v21 = _mm_sub_epi16(
            _mm_loadu_si128((const __m128i *)&v20[2 * v3 - 30]),
            _mm_loadu_si128((const __m128i *)(v20 - 30)));
    *(__m128i *)&v20[2 * v3 - 14] = _mm_sub_epi16(
                                      _mm_loadu_si128((const __m128i *)&v20[2 * v3 - 14]),
                                      _mm_loadu_si128((const __m128i *)(v20 - 14)));
    *(__m128i *)&v20[2 * v3 - 30] = v21;
    goto LABEL_18;
  }
LABEL_4:
  *(_WORD *)&v5[2 * v3] -= *(_WORD *)v5;
  v5 -= 2;
LABEL_5:
  *(_WORD *)&v5[2 * v3] -= *(_WORD *)v5;
  v5 -= 2;
LABEL_6:
  *(_WORD *)&v5[2 * v3] -= *(_WORD *)v5;
  v5 -= 2;
LABEL_7:
  *(_WORD *)&v5[2 * v3] -= *(_WORD *)v5;
  v5 -= 2;
  while ( 1 )
  {
    v9 = v4 <= v3;
    v4 -= v3;
    if ( v9 )
      return 1;
LABEL_9:
    switch ( v3 )
    {
      case 0LL:
        continue;
      case 1LL:
        goto LABEL_7;
      case 2LL:
        goto LABEL_6;
      case 3LL:
        goto LABEL_5;
      case 4LL:
        goto LABEL_4;
      default:
        goto LABEL_10;
    }
  }
}


int __fastcall horAcc32(TIFF *tif, uint8_t *cp0, tmsize_t cc)
{
  signed __int64 v3;
  signed __int64 v4;
  __int64 v5;
  unsigned __int64 v6;
  unsigned __int64 v7;
  char v8;
  signed __int64 v9;
  uint8_t *v10;
  __int64 v11;
  __int64 v12;
  __m128i v13;
  __m128i v14;
  __m128i v15;
  __m128i v16;
  __m128i v17;
  const __m128i *v18;
  __m128i v19;

  v3 = *((_QWORD *)tif->tif_data + 1);
  v4 = cc / 4 - v3;
  if ( cc / 4 <= v3 )
    return 1;
  v5 = v3 - 4;
  v6 = (unsigned __int64)(v3 - 12) >> 3;
  v7 = (v3 - 4) & 0xFFFFFFFFFFFFFFF8LL;
  if ( (unsigned __int64)v3 <= 4 )
    goto LABEL_9;
LABEL_10:
  if ( v5 > 0 )
  {
    if ( (unsigned __int64)v5 < 8 )
    {
      v9 = v3 - 4;
      do
      {
LABEL_19:
        *(_DWORD *)&cp0[4 * v3] += *(_DWORD *)cp0;
        cp0 += 4;
        v8 = (v9 - 1 < 0) ^ __OFADD__(-1LL, v9) | (v9 == 1);
        --v9;
      }
      while ( !v8 );
      goto LABEL_4;
    }
    if ( v6 )
    {
      v10 = &cp0[4 * v3 + 48];
      v11 = 0LL;
      v12 = v6 + 1 - (((_BYTE)v6 + 1) & 1);
      do
      {
        v13 = _mm_add_epi32(
                _mm_loadu_si128((const __m128i *)&v10[4 * v11 - 32]),
                _mm_loadu_si128((const __m128i *)&cp0[4 * v11 + 16]));
        v14 = _mm_loadu_si128((const __m128i *)&v10[4 * v11 - 16]);
        v15 = _mm_loadu_si128((const __m128i *)&v10[4 * v11]);
        *(__m128i *)&v10[4 * v11 - 48] = _mm_add_epi32(
                                           _mm_loadu_si128((const __m128i *)&v10[4 * v11 - 48]),
                                           _mm_loadu_si128((const __m128i *)&cp0[4 * v11]));
        *(__m128i *)&v10[4 * v11 - 32] = v13;
        v16 = _mm_add_epi32(_mm_loadu_si128((const __m128i *)&cp0[4 * v11 + 32]), v14);
        v17 = _mm_add_epi32(_mm_loadu_si128((const __m128i *)&cp0[4 * v11 + 48]), v15);
        *(__m128i *)&v10[4 * v11 - 16] = v16;
        *(__m128i *)&v10[4 * v11] = v17;
        v11 += 16LL;
        v12 -= 2LL;
      }
      while ( v12 );
      if ( (((_BYTE)v6 + 1) & 1) == 0 )
      {
LABEL_18:
        cp0 += 4 * v7;
        v9 = v3 - 4 - v7;
        if ( v5 == v7 )
          goto LABEL_4;
        goto LABEL_19;
      }
    }
    else
    {
      v11 = 0LL;
    }
    v18 = (const __m128i *)&cp0[4 * v11];
    v19 = _mm_add_epi32(_mm_loadu_si128((const __m128i *)((char *)v18 + 4 * v3 + 16)), _mm_loadu_si128(v18 + 1));
    *(const __m128i *)((char *)v18 + 4 * v3) = _mm_add_epi32(
                                                 _mm_loadu_si128((const __m128i *)((char *)v18 + 4 * v3)),
                                                 _mm_loadu_si128(v18));
    *(__m128i *)((char *)v18 + 4 * v3 + 16) = v19;
    goto LABEL_18;
  }
LABEL_4:
  *(_DWORD *)&cp0[4 * v3] += *(_DWORD *)cp0;
  cp0 += 4;
LABEL_5:
  *(_DWORD *)&cp0[4 * v3] += *(_DWORD *)cp0;
  cp0 += 4;
LABEL_6:
  *(_DWORD *)&cp0[4 * v3] += *(_DWORD *)cp0;
  cp0 += 4;
LABEL_7:
  *(_DWORD *)&cp0[4 * v3] += *(_DWORD *)cp0;
  cp0 += 4;
  while ( 1 )
  {
    v8 = v4 <= v3;
    v4 -= v3;
    if ( v8 )
      return 1;
LABEL_9:
    switch ( v3 )
    {
      case 0LL:
        continue;
      case 1LL:
        goto LABEL_7;
      case 2LL:
        goto LABEL_6;
      case 3LL:
        goto LABEL_5;
      case 4LL:
        goto LABEL_4;
      default:
        goto LABEL_10;
    }
  }
}


int __fastcall fpDiff(TIFF *tif, uint8_t *cp0, tmsize_t cc)
{
  tmsize_t v3;
  signed __int64 v4;
  signed __int64 v5;
  tmsize_t v6;
  char *v7;
  char *v8;
  char *v9;
  __int64 v10;
  __int64 v11;
  int v12;
  unsigned int v13;
  int result;
  uint8_t *v15;
  __int64 v16;
  unsigned __int64 v17;
  unsigned __int64 v18;
  signed __int64 v19;
  uint8_t *v20;
  __int64 v21;
  __int64 v22;
  __int64 v23;
  unsigned __int64 v24;
  unsigned __int64 v25;
  __int64 v26;
  uint8_t *v27;
  unsigned __int64 v28;
  char v29;

  v3 = cc;
  v4 = *((_QWORD *)tif->tif_data + 1);
  v5 = (unsigned __int64)tif->tif_dir.td_bitspersample >> 3;
  v6 = cc / v5;
  v7 = (char *)TIFFmalloc(cc);
  if ( !v7 )
    return 0;
  v8 = v7;
  TIFFmemcpy(v7, cp0, v3);
  if ( v6 > 0 )
  {
    v9 = v8 + 1;
    v10 = 0LL;
    if ( (_WORD)v5 )
      goto LABEL_6;
    while ( 1 )
    {
      do
      {
        ++v10;
        v9 += (unsigned __int16)v5;
        if ( v10 == v6 )
          goto LABEL_12;
      }
      while ( !(_WORD)v5 );
LABEL_6:
      if ( (_WORD)v5 == 1 )
        break;
      v13 = v5 - 2;
      v11 = 0LL;
      do
      {
        cp0[v10 + v6 * (v13 + 1)] = v9[v11 - 1];
        cp0[v10 + v6 * v13] = v9[v11];
        v11 += 2LL;
        v13 -= 2;
      }
      while ( (unsigned __int16)v5 - (unsigned __int64)(v5 & 1) != v11 );
      v12 = v11;
      if ( (v5 & 1) != 0 )
LABEL_11:
        cp0[v10 + v6 * (unsigned int)(v5 + ~v12)] = v8[v11 + v5 * v10];
    }
    v11 = 0LL;
    v12 = 0;
    goto LABEL_11;
  }
LABEL_12:
  TIFFfree(v8);
  result = 1;
  if ( v4 < v3 )
  {
    v15 = &cp0[v3 + ~v4];
    v16 = v4 - 4;
    v17 = (unsigned __int64)(v4 - 20) >> 4;
    v18 = (v4 - 4) & 0xFFFFFFFFFFFFFFF0LL;
    if ( (unsigned __int64)v4 <= 4 )
      goto LABEL_20;
LABEL_21:
    if ( v16 <= 0 )
      goto LABEL_15;
    if ( (unsigned __int64)v16 < 0x10 )
    {
      v19 = v4 - 4;
      goto LABEL_30;
    }
    if ( v17 )
    {
      v20 = v15 - 7;
      v21 = (__int64)&v15[v4 - 7];
      v22 = 0LL;
      v23 = v17 + 1 - (((_BYTE)v17 + 1) & 1);
      do
      {
        v24 = _mm_sub_epi8(
                _mm_loadl_epi64((const __m128i *)(v21 + v22 - 8)),
                _mm_loadl_epi64((const __m128i *)&v20[v22 - 8])).m128i_u64[0];
        *(_QWORD *)(v21 + v22) = _mm_sub_epi8(
                                   _mm_loadl_epi64((const __m128i *)(v21 + v22)),
                                   _mm_loadl_epi64((const __m128i *)&v20[v22])).m128i_u64[0];
        *(_QWORD *)(v21 + v22 - 8) = v24;
        v25 = _mm_sub_epi8(
                _mm_loadl_epi64((const __m128i *)(v21 + v22 - 24)),
                _mm_loadl_epi64((const __m128i *)&v20[v22 - 24])).m128i_u64[0];
        *(_QWORD *)(v21 + v22 - 16) = _mm_sub_epi8(
                                        _mm_loadl_epi64((const __m128i *)(v21 + v22 - 16)),
                                        _mm_loadl_epi64((const __m128i *)&v20[v22 - 16])).m128i_u64[0];
        *(_QWORD *)(v21 + v22 - 24) = v25;
        v22 -= 32LL;
        v23 -= 2LL;
      }
      while ( v23 );
      v26 = -v22;
      if ( (((_BYTE)v17 + 1) & 1) == 0 )
      {
LABEL_29:
        v15 -= (v4 - 4) & 0xFFFFFFFFFFFFFFF0LL;
        v19 = v4 - 4 - v18;
        if ( v16 == v18 )
        {
LABEL_15:
          v15[v4] -= *v15;
          --v15;
LABEL_16:
          v15[v4] -= *v15;
          --v15;
LABEL_17:
          v15[v4] -= *v15;
          --v15;
LABEL_18:
          v15[v4] -= *v15;
          --v15;
          while ( 1 )
          {
            v3 -= v4;
            if ( v3 <= v4 )
              return result;
LABEL_20:
            switch ( v4 )
            {
              case 0LL:
                continue;
              case 1LL:
                goto LABEL_18;
              case 2LL:
                goto LABEL_17;
              case 3LL:
                goto LABEL_16;
              case 4LL:
                goto LABEL_15;
              default:
                goto LABEL_21;
            }
          }
        }
        do
        {
LABEL_30:
          v15[v4] -= *v15;
          --v15;
          v29 = (v19 - 1 < 0) ^ __OFADD__(-1LL, v19) | (v19 == 1);
          --v19;
        }
        while ( !v29 );
        goto LABEL_15;
      }
    }
    else
    {
      v26 = 0LL;
    }
    v27 = &v15[-v26];
    v28 = _mm_sub_epi8(
            _mm_loadl_epi64((const __m128i *)&v15[v4 - v26 - 15]),
            _mm_loadl_epi64((const __m128i *)&v15[-v26 - 15])).m128i_u64[0];
    *(_QWORD *)&v27[v4 - 7] = _mm_sub_epi8(
                                _mm_loadl_epi64((const __m128i *)&v15[v4 - v26 - 7]),
                                _mm_loadl_epi64((const __m128i *)&v15[-v26 - 7])).m128i_u64[0];
    *(_QWORD *)&v27[v4 - 15] = v28;
    goto LABEL_29;
  }
  return result;
}


int __fastcall horAcc8(TIFF *tif, uint8_t *cp0, tmsize_t cc)
{
  tmsize_t v3;
  char v4;
  tmsize_t v5;
  int v6;
  int v7;
  int v8;
  uint8_t *v9;
  tmsize_t v10;
  int v11;
  int v12;
  int v13;
  int v14;
  uint8_t *v15;
  int v16;
  int v17;
  int v18;
  int v19;
  tmsize_t v20;
  __int64 v21;
  unsigned __int64 v22;
  unsigned __int64 v23;
  unsigned __int64 v24;
  uint8_t *v25;
  uint8_t *v26;
  __int64 v27;
  __int64 v28;
  __m128i v29;
  __m128i v30;
  __m128i v31;
  __m128i v32;
  __m128i v33;
  uint8_t *v34;
  __m128i v35;

  v3 = *((_QWORD *)tif->tif_data + 1);
  if ( v3 >= cc )
    return 1;
  if ( v3 == 4 )
  {
    v10 = cc - 4;
    if ( !((cc - 4 < 0) ^ __OFADD__(-4LL, cc) | (cc == 4)) )
    {
      v11 = cp0[3];
      v12 = cp0[2];
      v13 = cp0[1];
      v14 = *cp0;
      if ( (((_BYTE)cc - 5) & 4) == 0 )
      {
        v14 += cp0[4];
        cp0[4] = v14;
        v13 += cp0[5];
        cp0[5] = v13;
        v12 += cp0[6];
        cp0[6] = v12;
        v11 += cp0[7];
        cp0[7] = v11;
        cp0 += 4;
        v10 = cc - 8;
      }
      if ( (unsigned __int64)(cc - 5) >= 4 )
      {
        v15 = cp0 + 11;
        do
        {
          v16 = v14 + *(v15 - 7);
          *(v15 - 7) += v14;
          v17 = v13 + *(v15 - 6);
          *(v15 - 6) += v13;
          v18 = v12 + *(v15 - 5);
          *(v15 - 5) += v12;
          v19 = v11 + *(v15 - 4);
          *(v15 - 4) += v11;
          v14 = v16 + *(v15 - 3);
          *(v15 - 3) += v16;
          v13 = v17 + *(v15 - 2);
          *(v15 - 2) += v17;
          v12 = v18 + *(v15 - 1);
          *(v15 - 1) += v18;
          v11 = v19 + *v15;
          *v15 += v19;
          v15 += 8;
          v4 = (v10 - 8 < 0) ^ __OFADD__(-8LL, v10) | (v10 == 8);
          v10 -= 8LL;
        }
        while ( !v4 );
      }
    }
    return 1;
  }
  if ( v3 == 3 )
  {
    v4 = (cc - 3 < 0) ^ __OFADD__(-3LL, cc) | (cc == 3);
    v5 = cc - 3;
    if ( !v4 )
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
        v4 = (v5 - 3 < 0) ^ __OFADD__(-3LL, v5) | (v5 == 3);
        v5 -= 3LL;
      }
      while ( !v4 );
    }
    return 1;
  }
  v20 = cc - v3;
  v21 = v3 - 4;
  v22 = (unsigned __int64)(v3 - 36) >> 5;
  v23 = (v3 - 4) & 0xFFFFFFFFFFFFFFE0LL;
  if ( (unsigned __int64)v3 <= 4 )
    goto LABEL_22;
LABEL_23:
  if ( v21 <= 0 )
    goto LABEL_17;
  if ( (unsigned __int64)v21 < 0x20 )
  {
    v24 = v3 - 4;
    goto LABEL_32;
  }
  if ( !v22 )
  {
    v27 = 0LL;
LABEL_30:
    v34 = &cp0[v27];
    v35 = _mm_add_epi8(
            _mm_loadu_si128((const __m128i *)&cp0[v27 + 16]),
            _mm_loadu_si128((const __m128i *)&cp0[v27 + 16 + v3]));
    *(__m128i *)&v34[v3] = _mm_add_epi8(
                             _mm_loadu_si128((const __m128i *)&cp0[v27]),
                             _mm_loadu_si128((const __m128i *)&cp0[v27 + v3]));
    *(__m128i *)&v34[v3 + 16] = v35;
    goto LABEL_31;
  }
  v25 = cp0 + 48;
  v26 = &cp0[v3 + 48];
  v27 = 0LL;
  v28 = v22 + 1 - (((_BYTE)v22 + 1) & 1);
  do
  {
    v29 = _mm_add_epi8(
            _mm_loadu_si128((const __m128i *)&v26[v27 - 32]),
            _mm_loadu_si128((const __m128i *)&v25[v27 - 32]));
    v30 = _mm_loadu_si128((const __m128i *)&v26[v27 - 16]);
    v31 = _mm_loadu_si128((const __m128i *)&v26[v27]);
    *(__m128i *)&cp0[v3 + v27] = _mm_add_epi8(
                                   _mm_loadu_si128((const __m128i *)&cp0[v3 + v27]),
                                   _mm_loadu_si128((const __m128i *)&cp0[v27]));
    *(__m128i *)&v26[v27 - 32] = v29;
    v32 = _mm_add_epi8(_mm_loadu_si128((const __m128i *)&v25[v27 - 16]), v30);
    v33 = _mm_add_epi8(_mm_loadu_si128((const __m128i *)&v25[v27]), v31);
    *(__m128i *)&v26[v27 - 16] = v32;
    *(__m128i *)&v26[v27] = v33;
    v27 += 64LL;
    v28 -= 2LL;
  }
  while ( v28 );
  if ( (((_BYTE)v22 + 1) & 1) != 0 )
    goto LABEL_30;
LABEL_31:
  cp0 += v23;
  v24 = v3 - 4 - v23;
  if ( v21 != v23 )
  {
    do
    {
LABEL_32:
      cp0[v3] += *cp0;
      ++cp0;
      v4 = ((__int64)(v24 - 1) < 0) ^ __OFADD__(-1LL, v24) | (v24 == 1);
      --v24;
    }
    while ( !v4 );
  }
LABEL_17:
  cp0[v3] += *cp0;
  ++cp0;
LABEL_18:
  cp0[v3] += *cp0;
  ++cp0;
LABEL_19:
  cp0[v3] += *cp0;
  ++cp0;
LABEL_20:
  cp0[v3] += *cp0;
  ++cp0;
  while ( 1 )
  {
    v4 = v20 <= v3;
    v20 -= v3;
    if ( v4 )
      return 1;
LABEL_22:
    switch ( v3 )
    {
      case 0LL:
        continue;
      case 1LL:
        goto LABEL_20;
      case 2LL:
        goto LABEL_19;
      case 3LL:
        goto LABEL_18;
      case 4LL:
        goto LABEL_17;
      default:
        goto LABEL_23;
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
    v9 = (unsigned int (__fastcall *)(TIFF *, uint8_t *, _QWORD))*((_QWORD *)tif_data + 10);
    if ( !v9 )
      __assert_fail(
        "sp->decodepfunc != NULL",
        "tif_predict.c",
        0x20Au,
        "int PredictorDecodeTile(TIFF *, uint8_t *, tmsize_t, uint16_t)");
    if ( v6 <= 0 )
      return 1;
    if ( v9(tif, op0, *((_QWORD *)tif_data + 2)) )
    {
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
      return 1;
    }
  }
  return v7;
}


int __fastcall horDiff32(TIFF *tif, uint8_t *cp0, tmsize_t cc)
{
  signed __int64 v3;
  signed __int64 v4;
  uint8_t *v5;
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
  __int64 v18;
  uint8_t *v19;
  __m128i v20;

  v3 = *((_QWORD *)tif->tif_data + 1);
  v4 = cc / 4 - v3;
  if ( cc / 4 <= v3 )
    return 1;
  v5 = &cp0[4 * v4 - 4];
  v6 = v3 - 4;
  v7 = (unsigned __int64)(v3 - 12) >> 3;
  v8 = (v3 - 4) & 0xFFFFFFFFFFFFFFF8LL;
  if ( (unsigned __int64)v3 <= 4 )
    goto LABEL_9;
LABEL_10:
  if ( v6 > 0 )
  {
    if ( (unsigned __int64)v6 < 8 )
    {
      v10 = v3 - 4;
      do
      {
LABEL_19:
        *(_DWORD *)&v5[4 * v3] -= *(_DWORD *)v5;
        v5 -= 4;
        v9 = (v10 - 1 < 0) ^ __OFADD__(-1LL, v10) | (v10 == 1);
        --v10;
      }
      while ( !v9 );
      goto LABEL_4;
    }
    if ( v7 )
    {
      v11 = &v5[4 * v3 - 12];
      v12 = 0LL;
      v13 = v7 + 1 - (((_BYTE)v7 + 1) & 1);
      do
      {
        v14 = _mm_loadu_si128((const __m128i *)&v11[4 * v12 - 48]);
        v15 = _mm_loadu_si128((const __m128i *)&v11[4 * v12 - 32]);
        v16 = _mm_sub_epi32(
                _mm_loadu_si128((const __m128i *)&v11[4 * v12 - 16]),
                _mm_loadu_si128((const __m128i *)&v5[4 * v12 - 28]));
        *(__m128i *)&v11[4 * v12] = _mm_sub_epi32(
                                      _mm_loadu_si128((const __m128i *)&v11[4 * v12]),
                                      _mm_loadu_si128((const __m128i *)&v5[4 * v12 - 12]));
        *(__m128i *)&v11[4 * v12 - 16] = v16;
        v17 = _mm_sub_epi32(v14, _mm_loadu_si128((const __m128i *)&v5[4 * v12 - 60]));
        *(__m128i *)&v11[4 * v12 - 32] = _mm_sub_epi32(v15, _mm_loadu_si128((const __m128i *)&v5[4 * v12 - 44]));
        *(__m128i *)&v11[4 * v12 - 48] = v17;
        v12 -= 16LL;
        v13 -= 2LL;
      }
      while ( v13 );
      v18 = -v12;
      if ( (((_BYTE)v7 + 1) & 1) == 0 )
      {
LABEL_18:
        v5 -= 4 * ((v3 - 4) & 0xFFFFFFFFFFFFFFF8LL);
        v10 = v3 - 4 - v8;
        if ( v6 == v8 )
          goto LABEL_4;
        goto LABEL_19;
      }
    }
    else
    {
      v18 = 0LL;
    }
    v19 = &v5[-4 * v18];
    v20 = _mm_sub_epi32(
            _mm_loadu_si128((const __m128i *)&v19[4 * v3 - 28]),
            _mm_loadu_si128((const __m128i *)(v19 - 28)));
    *(__m128i *)&v19[4 * v3 - 12] = _mm_sub_epi32(
                                      _mm_loadu_si128((const __m128i *)&v19[4 * v3 - 12]),
                                      _mm_loadu_si128((const __m128i *)(v19 - 12)));
    *(__m128i *)&v19[4 * v3 - 28] = v20;
    goto LABEL_18;
  }
LABEL_4:
  *(_DWORD *)&v5[4 * v3] -= *(_DWORD *)v5;
  v5 -= 4;
LABEL_5:
  *(_DWORD *)&v5[4 * v3] -= *(_DWORD *)v5;
  v5 -= 4;
LABEL_6:
  *(_DWORD *)&v5[4 * v3] -= *(_DWORD *)v5;
  v5 -= 4;
LABEL_7:
  *(_DWORD *)&v5[4 * v3] -= *(_DWORD *)v5;
  v5 -= 4;
  while ( 1 )
  {
    v9 = v4 <= v3;
    v4 -= v3;
    if ( v9 )
      return 1;
LABEL_9:
    switch ( v3 )
    {
      case 0LL:
        continue;
      case 1LL:
        goto LABEL_7;
      case 2LL:
        goto LABEL_6;
      case 3LL:
        goto LABEL_5;
      case 4LL:
        goto LABEL_4;
      default:
        goto LABEL_10;
    }
  }
}


int __fastcall fpAcc(TIFF *tif, uint8_t *cp0, tmsize_t cc)
{
  tmsize_t v5;
  signed __int64 v6;
  tmsize_t v7;
  void *v8;
  void *v9;
  __int64 v10;
  unsigned __int64 v11;
  uint8_t *v12;
  tmsize_t v13;
  unsigned __int64 v14;
  uint8_t *v15;
  __int64 v16;
  __int64 v17;
  __int64 v18;
  __m128i v19;
  __m128i v20;
  __m128i v21;
  __m128i v22;
  __m128i v23;
  unsigned __int64 v24;
  uint8_t *v25;
  __m128i v26;
  char v27;
  uint8_t *v28;
  __int64 v29;
  __int64 v30;
  int v31;
  unsigned int v32;
  __int64 v34;
  __int64 v35;
  unsigned __int64 v36;

  v5 = *((_QWORD *)tif->tif_data + 1);
  v6 = (unsigned __int64)tif->tif_dir.td_bitspersample >> 3;
  v7 = cc / v6;
  v8 = TIFFmalloc(cc);
  if ( !v8 )
    return 0;
  v9 = v8;
  if ( v5 < cc )
  {
    v10 = v5 - 4;
    v11 = (unsigned __int64)(v5 - 36) >> 5;
    v36 = (v5 - 4) & 0xFFFFFFFFFFFFFFE0LL;
    v35 = ((_BYTE)v11 + 1) & 1;
    v34 = v11 + 1 - v35;
    v12 = cp0;
    v13 = cc;
    if ( (unsigned __int64)v5 <= 4 )
      goto LABEL_10;
LABEL_11:
    if ( v10 <= 0 )
      goto LABEL_5;
    if ( (unsigned __int64)v10 < 0x20 )
    {
      v14 = v5 - 4;
      do
      {
LABEL_20:
        v12[v5] += *v12;
        ++v12;
        v27 = ((__int64)(v14 - 1) < 0) ^ __OFADD__(-1LL, v14) | (v14 == 1);
        --v14;
      }
      while ( !v27 );
LABEL_5:
      v12[v5] += *v12;
      ++v12;
LABEL_6:
      v12[v5] += *v12;
      ++v12;
LABEL_7:
      v12[v5] += *v12;
      ++v12;
LABEL_8:
      v12[v5] += *v12;
      ++v12;
      while ( 1 )
      {
        v13 -= v5;
        if ( v13 <= v5 )
          goto LABEL_24;
LABEL_10:
        switch ( v5 )
        {
          case 0LL:
            continue;
          case 1LL:
            goto LABEL_8;
          case 2LL:
            goto LABEL_7;
          case 3LL:
            goto LABEL_6;
          case 4LL:
            goto LABEL_5;
          default:
            goto LABEL_11;
        }
      }
    }
    if ( v11 )
    {
      v15 = v12 + 48;
      v16 = (__int64)&v12[v5 + 48];
      v17 = 0LL;
      v18 = v34;
      do
      {
        v19 = _mm_add_epi8(
                _mm_loadu_si128((const __m128i *)(v16 + v17 - 32)),
                _mm_loadu_si128((const __m128i *)&v15[v17 - 32]));
        v20 = _mm_loadu_si128((const __m128i *)(v16 + v17 - 16));
        v21 = _mm_loadu_si128((const __m128i *)(v16 + v17));
        *(__m128i *)&v12[v5 + v17] = _mm_add_epi8(
                                       _mm_loadu_si128((const __m128i *)&v12[v5 + v17]),
                                       _mm_loadu_si128((const __m128i *)&v12[v17]));
        *(__m128i *)(v16 + v17 - 32) = v19;
        v22 = _mm_add_epi8(_mm_loadu_si128((const __m128i *)&v15[v17 - 16]), v20);
        v23 = _mm_add_epi8(_mm_loadu_si128((const __m128i *)&v15[v17]), v21);
        *(__m128i *)(v16 + v17 - 16) = v22;
        *(__m128i *)(v16 + v17) = v23;
        v17 += 64LL;
        v18 -= 2LL;
      }
      while ( v18 );
      if ( v35 )
        goto LABEL_18;
    }
    else
    {
      v17 = 0LL;
      if ( v35 )
      {
LABEL_18:
        v24 = v11;
        v25 = &v12[v17];
        v26 = _mm_add_epi8(
                _mm_loadu_si128((const __m128i *)&v12[v17 + 16]),
                _mm_loadu_si128((const __m128i *)&v12[v17 + 16 + v5]));
        *(__m128i *)&v25[v5] = _mm_add_epi8(
                                 _mm_loadu_si128((const __m128i *)&v12[v17]),
                                 _mm_loadu_si128((const __m128i *)&v12[v17 + v5]));
        *(__m128i *)&v25[v5 + 16] = v26;
        v11 = v24;
      }
    }
    v12 += v36;
    v14 = v5 - 4 - v36;
    if ( v10 == v36 )
      goto LABEL_5;
    goto LABEL_20;
  }
LABEL_24:
  TIFFmemcpy(v9, cp0, cc);
  if ( v7 > 0 )
  {
    v28 = cp0 + 1;
    v29 = 0LL;
    if ( (_WORD)v6 )
      goto LABEL_28;
    while ( 1 )
    {
      do
      {
        ++v29;
        v28 += (unsigned __int16)v6;
        if ( v29 == v7 )
          goto LABEL_34;
      }
      while ( !(_WORD)v6 );
LABEL_28:
      if ( (_WORD)v6 == 1 )
        break;
      v32 = v6 - 2;
      v30 = 0LL;
      do
      {
        v28[v30 - 1] = *((_BYTE *)v9 + v29 + v7 * (v32 + 1));
        v28[v30] = *((_BYTE *)v9 + v29 + v7 * v32);
        v30 += 2LL;
        v32 -= 2;
      }
      while ( (unsigned __int16)v6 - (unsigned __int64)(v6 & 1) != v30 );
      v31 = v30;
      if ( (v6 & 1) != 0 )
LABEL_33:
        cp0[v30 + v6 * v29] = *((_BYTE *)v9 + v29 + v7 * (unsigned int)(v6 + ~v31));
    }
    v30 = 0LL;
    v31 = 0;
    goto LABEL_33;
  }
LABEL_34:
  TIFFfree(v9);
  return 1;
}


int __fastcall horAcc16(TIFF *tif, uint8_t *cp0, tmsize_t cc)
{
  signed __int64 v3;
  signed __int64 v4;
  __int64 v5;
  unsigned __int64 v6;
  unsigned __int64 v7;
  char v8;
  signed __int64 v9;
  uint8_t *v10;
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
  v4 = cc / 2 - v3;
  if ( cc / 2 <= v3 )
    return 1;
  v5 = v3 - 4;
  v6 = (unsigned __int64)(v3 - 20) >> 4;
  v7 = (v3 - 4) & 0xFFFFFFFFFFFFFFF0LL;
  if ( (unsigned __int64)v3 <= 4 )
    goto LABEL_9;
LABEL_10:
  if ( v5 > 0 )
  {
    if ( (unsigned __int64)v5 < 0x10 )
    {
      v9 = v3 - 4;
      do
      {
LABEL_19:
        *(_WORD *)&cp0[2 * v3] += *(_WORD *)cp0;
        cp0 += 2;
        v8 = (v9 - 1 < 0) ^ __OFADD__(-1LL, v9) | (v9 == 1);
        --v9;
      }
      while ( !v8 );
      goto LABEL_4;
    }
    if ( v6 )
    {
      v10 = cp0 + 48;
      v11 = &cp0[2 * v3 + 48];
      v12 = 0LL;
      v13 = v6 + 1 - (((_BYTE)v6 + 1) & 1);
      do
      {
        v14 = _mm_add_epi16(
                _mm_loadu_si128((const __m128i *)&v11[2 * v12 - 32]),
                _mm_loadu_si128((const __m128i *)&v10[2 * v12 - 32]));
        v15 = _mm_loadu_si128((const __m128i *)&v11[2 * v12 - 16]);
        v16 = _mm_loadu_si128((const __m128i *)&v11[2 * v12]);
        *(__m128i *)&cp0[2 * v3 + 2 * v12] = _mm_add_epi16(
                                               _mm_loadu_si128((const __m128i *)&cp0[2 * v3 + 2 * v12]),
                                               _mm_loadu_si128((const __m128i *)&cp0[2 * v12]));
        *(__m128i *)&v11[2 * v12 - 32] = v14;
        v17 = _mm_add_epi16(_mm_loadu_si128((const __m128i *)&v10[2 * v12 - 16]), v15);
        v18 = _mm_add_epi16(_mm_loadu_si128((const __m128i *)&v10[2 * v12]), v16);
        *(__m128i *)&v11[2 * v12 - 16] = v17;
        *(__m128i *)&v11[2 * v12] = v18;
        v12 += 32LL;
        v13 -= 2LL;
      }
      while ( v13 );
      if ( (((_BYTE)v6 + 1) & 1) == 0 )
      {
LABEL_18:
        cp0 += 2 * v7;
        v9 = v3 - 4 - v7;
        if ( v5 == v7 )
          goto LABEL_4;
        goto LABEL_19;
      }
    }
    else
    {
      v12 = 0LL;
    }
    v19 = (const __m128i *)&cp0[2 * v12];
    v20 = _mm_add_epi16(_mm_loadu_si128(v19 + 1), _mm_loadu_si128((const __m128i *)((char *)v19 + 2 * v3 + 16)));
    *(const __m128i *)((char *)v19 + 2 * v3) = _mm_add_epi16(
                                                 _mm_loadu_si128(v19),
                                                 _mm_loadu_si128((const __m128i *)((char *)v19 + 2 * v3)));
    *(__m128i *)((char *)v19 + 2 * v3 + 16) = v20;
    goto LABEL_18;
  }
LABEL_4:
  *(_WORD *)&cp0[2 * v3] += *(_WORD *)cp0;
  cp0 += 2;
LABEL_5:
  *(_WORD *)&cp0[2 * v3] += *(_WORD *)cp0;
  cp0 += 2;
LABEL_6:
  *(_WORD *)&cp0[2 * v3] += *(_WORD *)cp0;
  cp0 += 2;
LABEL_7:
  *(_WORD *)&cp0[2 * v3] += *(_WORD *)cp0;
  cp0 += 2;
  while ( 1 )
  {
    v8 = v4 <= v3;
    v4 -= v3;
    if ( v8 )
      return 1;
LABEL_9:
    switch ( v3 )
    {
      case 0LL:
        continue;
      case 1LL:
        goto LABEL_7;
      case 2LL:
        goto LABEL_6;
      case 3LL:
        goto LABEL_5;
      case 4LL:
        goto LABEL_4;
      default:
        goto LABEL_10;
    }
  }
}


int __fastcall PredictorEncodeTile(TIFF *tif, uint8_t *bp0, tmsize_t cc0, uint16_t s)
{
  uint8_t *tif_data;
  char *v7;
  char *v8;
  __int64 v9;
  char *v10;
  __int64 v11;
  bool v12;
  int v13;
  uint16_t v15;
  tmsize_t v16;

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
  if ( v7 )
  {
    v8 = v7;
    v15 = s;
    memcpy(v7, bp0, cc0);
    v9 = *((_QWORD *)tif_data + 2);
    if ( v9 <= 0 )
      __assert_fail(
        "rowsize > 0",
        "tif_predict.c",
        0x30Bu,
        "int PredictorEncodeTile(TIFF *, uint8_t *, tmsize_t, uint16_t)");
    v16 = cc0;
    if ( cc0 > 0 )
    {
      v10 = v8;
      v11 = v16;
      do
      {
        (*((void (__fastcall **)(TIFF *, char *, __int64))tif_data + 6))(tif, v10, v9);
        v10 += v9;
        v12 = v11 <= v9;
        v11 -= v9;
      }
      while ( !v12 );
    }
    v13 = (*((__int64 (__fastcall **)(TIFF *, char *, tmsize_t, _QWORD))tif_data + 5))(tif, v8, v16, v15);
    TIFFfree(v8);
    return v13;
  }
  else
  {
    TIFFErrorExt(tif->tif_clientdata, "PredictorEncodeTile", "Out of memory allocating %ld byte temp buffer.", cc0);
    return 0;
  }
}


int __fastcall horDiff8(TIFF *tif, uint8_t *cp0, tmsize_t cc)
{
  tmsize_t v3;
  tmsize_t v4;
  uint8_t v5;
  uint8_t v6;
  uint8_t v7;
  uint8_t *v8;
  uint8_t v9;
  uint8_t v10;
  uint8_t v11;
  char v12;
  uint8_t v13;
  uint8_t v14;
  uint8_t v15;
  uint8_t v16;
  uint8_t *v17;
  uint8_t v18;
  uint8_t v19;
  uint8_t v20;
  uint8_t v21;
  uint8_t *v22;
  __int64 v23;
  unsigned __int64 v24;
  unsigned __int64 v25;
  unsigned __int64 v26;
  uint8_t *v27;
  __int64 v28;
  __int64 v29;
  __int64 v30;
  unsigned __int64 v31;
  unsigned __int64 v32;
  __int64 v33;
  uint8_t *v34;
  unsigned __int64 v35;

  v3 = *((_QWORD *)tif->tif_data + 1);
  if ( v3 >= cc )
    return 1;
  v4 = cc - v3;
  if ( v3 == 4 )
  {
    v13 = *cp0;
    v14 = cp0[1];
    v15 = cp0[2];
    v16 = cp0[3];
    v17 = cp0 + 7;
    do
    {
      v18 = *(v17 - 3);
      v19 = *(v17 - 2);
      *(v17 - 3) = v18 - v13;
      *(v17 - 2) = v19 - v14;
      v20 = *(v17 - 1);
      *(v17 - 1) = v20 - v15;
      v21 = *v17;
      *v17 -= v16;
      v17 += 4;
      v13 = v18;
      v14 = v19;
      v15 = v20;
      v16 = v21;
      v12 = (v4 - 4 < 0) ^ __OFADD__(-4LL, v4) | (v4 == 4);
      v4 -= 4LL;
    }
    while ( !v12 );
    return 1;
  }
  if ( v3 == 3 )
  {
    v5 = *cp0;
    v6 = cp0[1];
    v7 = cp0[2];
    v8 = cp0 + 5;
    do
    {
      v9 = *(v8 - 2);
      v10 = *(v8 - 1);
      *(v8 - 2) = v9 - v5;
      *(v8 - 1) = v10 - v6;
      v11 = *v8;
      *v8 -= v7;
      v8 += 3;
      v7 = v11;
      v6 = v10;
      v5 = v9;
      v12 = (v4 - 3 < 0) ^ __OFADD__(-3LL, v4) | (v4 == 3);
      v4 -= 3LL;
    }
    while ( !v12 );
    return 1;
  }
  v22 = &cp0[v4 - 1];
  v23 = v3 - 4;
  v24 = (unsigned __int64)(v3 - 20) >> 4;
  v25 = (v3 - 4) & 0xFFFFFFFFFFFFFFF0LL;
  if ( (unsigned __int64)v3 <= 4 )
    goto LABEL_17;
LABEL_18:
  if ( v23 <= 0 )
    goto LABEL_12;
  if ( (unsigned __int64)v23 < 0x10 )
  {
    v26 = v3 - 4;
    goto LABEL_27;
  }
  if ( !v24 )
  {
    v33 = 0LL;
LABEL_25:
    v34 = &v22[-v33];
    v35 = _mm_sub_epi8(
            _mm_loadl_epi64((const __m128i *)&v22[v3 - v33 - 15]),
            _mm_loadl_epi64((const __m128i *)&v22[-v33 - 15])).m128i_u64[0];
    *(_QWORD *)&v34[v3 - 7] = _mm_sub_epi8(
                                _mm_loadl_epi64((const __m128i *)&v22[v3 - v33 - 7]),
                                _mm_loadl_epi64((const __m128i *)&v22[-v33 - 7])).m128i_u64[0];
    *(_QWORD *)&v34[v3 - 15] = v35;
    goto LABEL_26;
  }
  v27 = v22 - 7;
  v28 = (__int64)&v22[v3 - 7];
  v29 = 0LL;
  v30 = v24 + 1 - (((_BYTE)v24 + 1) & 1);
  do
  {
    v31 = _mm_sub_epi8(
            _mm_loadl_epi64((const __m128i *)(v28 + v29 - 8)),
            _mm_loadl_epi64((const __m128i *)&v27[v29 - 8])).m128i_u64[0];
    *(_QWORD *)(v28 + v29) = _mm_sub_epi8(
                               _mm_loadl_epi64((const __m128i *)(v28 + v29)),
                               _mm_loadl_epi64((const __m128i *)&v27[v29])).m128i_u64[0];
    *(_QWORD *)(v28 + v29 - 8) = v31;
    v32 = _mm_sub_epi8(
            _mm_loadl_epi64((const __m128i *)(v28 + v29 - 24)),
            _mm_loadl_epi64((const __m128i *)&v27[v29 - 24])).m128i_u64[0];
    *(_QWORD *)(v28 + v29 - 16) = _mm_sub_epi8(
                                    _mm_loadl_epi64((const __m128i *)(v28 + v29 - 16)),
                                    _mm_loadl_epi64((const __m128i *)&v27[v29 - 16])).m128i_u64[0];
    *(_QWORD *)(v28 + v29 - 24) = v32;
    v29 -= 32LL;
    v30 -= 2LL;
  }
  while ( v30 );
  v33 = -v29;
  if ( (((_BYTE)v24 + 1) & 1) != 0 )
    goto LABEL_25;
LABEL_26:
  v22 -= (v3 - 4) & 0xFFFFFFFFFFFFFFF0LL;
  v26 = v3 - 4 - v25;
  if ( v23 != v25 )
  {
    do
    {
LABEL_27:
      v22[v3] -= *v22;
      --v22;
      v12 = ((__int64)(v26 - 1) < 0) ^ __OFADD__(-1LL, v26) | (v26 == 1);
      --v26;
    }
    while ( !v12 );
  }
LABEL_12:
  v22[v3] -= *v22;
  --v22;
LABEL_13:
  v22[v3] -= *v22;
  --v22;
LABEL_14:
  v22[v3] -= *v22;
  --v22;
LABEL_15:
  v22[v3] -= *v22;
  --v22;
  while ( 1 )
  {
    v12 = v4 <= v3;
    v4 -= v3;
    if ( v12 )
      return 1;
LABEL_17:
    switch ( v3 )
    {
      case 0LL:
        continue;
      case 1LL:
        goto LABEL_15;
      case 2LL:
        goto LABEL_14;
      case 3LL:
        goto LABEL_13;
      case 4LL:
        goto LABEL_12;
      default:
        goto LABEL_18;
    }
  }
}
