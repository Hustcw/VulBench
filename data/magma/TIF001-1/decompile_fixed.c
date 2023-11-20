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
