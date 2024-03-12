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
