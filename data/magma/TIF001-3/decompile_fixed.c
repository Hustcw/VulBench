int __fastcall horAcc32(TIFF *tif, uint8_t *cp0, tmsize_t cc)
{
  signed __int64 v3;
  int v4;
  signed __int64 v5;
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
  __m128i v18;
  const __m128i *v19;
  __m128i v20;

  v3 = *((_QWORD *)tif->tif_data + 1);
  if ( cc % (4 * v3) )
  {
    v4 = 0;
    TIFFErrorExt(tif->tif_clientdata, "horAcc32", "%s", "cc%(4*stride))!=0");
    return v4;
  }
  v4 = 1;
  v5 = cc / 4 - v3;
  if ( cc / 4 <= v3 )
    return v4;
  v6 = v3 - 4;
  v7 = (unsigned __int64)(v3 - 12) >> 3;
  v8 = (v3 - 4) & 0xFFFFFFFFFFFFFFF8LL;
  if ( (unsigned __int64)v3 <= 4 )
    goto LABEL_11;
LABEL_12:
  if ( v6 <= 0 )
    goto LABEL_6;
  if ( (unsigned __int64)v6 < 8 )
  {
    v10 = v3 - 4;
    goto LABEL_21;
  }
  if ( !v7 )
  {
    v12 = 0LL;
LABEL_19:
    v19 = (const __m128i *)&cp0[4 * v12];
    v20 = _mm_add_epi32(_mm_loadu_si128((const __m128i *)((char *)v19 + 4 * v3 + 16)), _mm_loadu_si128(v19 + 1));
    *(const __m128i *)((char *)v19 + 4 * v3) = _mm_add_epi32(
                                                 _mm_loadu_si128((const __m128i *)((char *)v19 + 4 * v3)),
                                                 _mm_loadu_si128(v19));
    *(__m128i *)((char *)v19 + 4 * v3 + 16) = v20;
    goto LABEL_20;
  }
  v11 = &cp0[4 * v3 + 48];
  v12 = 0LL;
  v13 = v7 + 1 - (((_BYTE)v7 + 1) & 1);
  do
  {
    v14 = _mm_add_epi32(
            _mm_loadu_si128((const __m128i *)&v11[4 * v12 - 32]),
            _mm_loadu_si128((const __m128i *)&cp0[4 * v12 + 16]));
    v15 = _mm_loadu_si128((const __m128i *)&v11[4 * v12 - 16]);
    v16 = _mm_loadu_si128((const __m128i *)&v11[4 * v12]);
    *(__m128i *)&v11[4 * v12 - 48] = _mm_add_epi32(
                                       _mm_loadu_si128((const __m128i *)&v11[4 * v12 - 48]),
                                       _mm_loadu_si128((const __m128i *)&cp0[4 * v12]));
    *(__m128i *)&v11[4 * v12 - 32] = v14;
    v17 = _mm_add_epi32(_mm_loadu_si128((const __m128i *)&cp0[4 * v12 + 32]), v15);
    v18 = _mm_add_epi32(_mm_loadu_si128((const __m128i *)&cp0[4 * v12 + 48]), v16);
    *(__m128i *)&v11[4 * v12 - 16] = v17;
    *(__m128i *)&v11[4 * v12] = v18;
    v12 += 16LL;
    v13 -= 2LL;
  }
  while ( v13 );
  if ( (((_BYTE)v7 + 1) & 1) != 0 )
    goto LABEL_19;
LABEL_20:
  cp0 += 4 * v8;
  v10 = v3 - 4 - v8;
  if ( v6 != v8 )
  {
    do
    {
LABEL_21:
      *(_DWORD *)&cp0[4 * v3] += *(_DWORD *)cp0;
      cp0 += 4;
      v9 = (v10 - 1 < 0) ^ __OFADD__(-1LL, v10) | (v10 == 1);
      --v10;
    }
    while ( !v9 );
  }
LABEL_6:
  *(_DWORD *)&cp0[4 * v3] += *(_DWORD *)cp0;
  cp0 += 4;
LABEL_7:
  *(_DWORD *)&cp0[4 * v3] += *(_DWORD *)cp0;
  cp0 += 4;
LABEL_8:
  *(_DWORD *)&cp0[4 * v3] += *(_DWORD *)cp0;
  cp0 += 4;
LABEL_9:
  *(_DWORD *)&cp0[4 * v3] += *(_DWORD *)cp0;
  cp0 += 4;
  while ( 1 )
  {
    v9 = v5 <= v3;
    v5 -= v3;
    if ( v9 )
      return v4;
LABEL_11:
    switch ( v3 )
    {
      case 0LL:
        continue;
      case 1LL:
        goto LABEL_9;
      case 2LL:
        goto LABEL_8;
      case 3LL:
        goto LABEL_7;
      case 4LL:
        goto LABEL_6;
      default:
        goto LABEL_12;
    }
  }
}
