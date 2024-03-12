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
