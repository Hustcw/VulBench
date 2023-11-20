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
