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
