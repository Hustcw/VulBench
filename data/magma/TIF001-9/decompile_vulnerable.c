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
