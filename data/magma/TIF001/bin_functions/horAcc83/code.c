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
