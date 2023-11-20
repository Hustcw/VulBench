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
