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
