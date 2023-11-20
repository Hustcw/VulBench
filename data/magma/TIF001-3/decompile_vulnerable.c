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
