int __fastcall horAcc16(TIFF *tif, uint8_t *cp0, tmsize_t cc)
{
  signed __int64 v3;
  __int64 v4;
  int v5;
  signed __int64 v6;
  __int64 v7;
  unsigned __int64 v8;
  unsigned __int64 v9;
  char v10;
  signed __int64 v11;
  uint8_t *v12;
  uint8_t *v13;
  __int64 v14;
  __int64 v15;
  __m128i v16;
  __m128i v17;
  __m128i v18;
  __m128i v19;
  __m128i v20;
  const __m128i *v21;
  __m128i v22;

  v3 = *((_QWORD *)tif->tif_data + 1);
  v4 = 2 * v3;
  if ( cc % (2 * v3) )
  {
    v5 = 0;
    TIFFErrorExt(tif->tif_clientdata, "horAcc16", "%s", "cc%(2*stride))!=0");
    return v5;
  }
  v5 = 1;
  v6 = cc / 2 - v3;
  if ( cc / 2 <= v3 )
    return v5;
  v7 = v3 - 4;
  v8 = (unsigned __int64)(v3 - 20) >> 4;
  v9 = (v3 - 4) & 0xFFFFFFFFFFFFFFF0LL;
  if ( (unsigned __int64)v3 <= 4 )
    goto LABEL_11;
LABEL_12:
  if ( v7 <= 0 )
    goto LABEL_6;
  if ( (unsigned __int64)v7 < 0x10 )
  {
    v11 = v3 - 4;
    goto LABEL_21;
  }
  if ( !v8 )
  {
    v14 = 0LL;
LABEL_19:
    v21 = (const __m128i *)&cp0[2 * v14];
    v22 = _mm_add_epi16(_mm_loadu_si128(v21 + 1), _mm_loadu_si128((const __m128i *)((char *)v21 + 2 * v3 + 16)));
    *(const __m128i *)((char *)v21 + 2 * v3) = _mm_add_epi16(
                                                 _mm_loadu_si128(v21),
                                                 _mm_loadu_si128((const __m128i *)((char *)v21 + 2 * v3)));
    *(__m128i *)((char *)v21 + 2 * v3 + 16) = v22;
    goto LABEL_20;
  }
  v12 = cp0 + 48;
  v13 = &cp0[v4 + 48];
  v14 = 0LL;
  v15 = v8 + 1 - (((_BYTE)v8 + 1) & 1);
  do
  {
    v16 = _mm_add_epi16(
            _mm_loadu_si128((const __m128i *)&v13[2 * v14 - 32]),
            _mm_loadu_si128((const __m128i *)&v12[2 * v14 - 32]));
    v17 = _mm_loadu_si128((const __m128i *)&v13[2 * v14 - 16]);
    v18 = _mm_loadu_si128((const __m128i *)&v13[2 * v14]);
    *(__m128i *)&cp0[2 * v14 + v4] = _mm_add_epi16(
                                       _mm_loadu_si128((const __m128i *)&cp0[2 * v14 + v4]),
                                       _mm_loadu_si128((const __m128i *)&cp0[2 * v14]));
    *(__m128i *)&v13[2 * v14 - 32] = v16;
    v19 = _mm_add_epi16(_mm_loadu_si128((const __m128i *)&v12[2 * v14 - 16]), v17);
    v20 = _mm_add_epi16(_mm_loadu_si128((const __m128i *)&v12[2 * v14]), v18);
    *(__m128i *)&v13[2 * v14 - 16] = v19;
    *(__m128i *)&v13[2 * v14] = v20;
    v14 += 32LL;
    v15 -= 2LL;
  }
  while ( v15 );
  if ( (((_BYTE)v8 + 1) & 1) != 0 )
    goto LABEL_19;
LABEL_20:
  cp0 += 2 * v9;
  v11 = v3 - 4 - v9;
  if ( v7 != v9 )
  {
    do
    {
LABEL_21:
      *(_WORD *)&cp0[2 * v3] += *(_WORD *)cp0;
      cp0 += 2;
      v10 = (v11 - 1 < 0) ^ __OFADD__(-1LL, v11) | (v11 == 1);
      --v11;
    }
    while ( !v10 );
  }
LABEL_6:
  *(_WORD *)&cp0[2 * v3] += *(_WORD *)cp0;
  cp0 += 2;
LABEL_7:
  *(_WORD *)&cp0[2 * v3] += *(_WORD *)cp0;
  cp0 += 2;
LABEL_8:
  *(_WORD *)&cp0[2 * v3] += *(_WORD *)cp0;
  cp0 += 2;
LABEL_9:
  *(_WORD *)&cp0[2 * v3] += *(_WORD *)cp0;
  cp0 += 2;
  while ( 1 )
  {
    v10 = v6 <= v3;
    v6 -= v3;
    if ( v10 )
      return v5;
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
