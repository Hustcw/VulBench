int __fastcall horDiff16(TIFF *tif, uint8_t *cp0, tmsize_t cc)
{
  signed __int64 v3;
  int v4;
  signed __int64 v5;
  uint8_t *v6;
  __int64 v7;
  unsigned __int64 v8;
  unsigned __int64 v9;
  char v10;
  signed __int64 v11;
  uint8_t *v12;
  __int64 v13;
  __int64 v14;
  __int64 v15;
  __m128i v16;
  __m128i v17;
  __m128i v18;
  __m128i v19;
  __int64 v20;
  uint8_t *v21;
  __m128i v22;

  v3 = *((_QWORD *)tif->tif_data + 1);
  if ( cc % (2 * v3) )
  {
    v4 = 0;
    TIFFErrorExt(tif->tif_clientdata, "horDiff8", "%s", "(cc%(2*stride))!=0");
    return v4;
  }
  v4 = 1;
  v5 = cc / 2 - v3;
  if ( cc / 2 <= v3 )
    return v4;
  v6 = &cp0[2 * v5 - 2];
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
    v20 = 0LL;
LABEL_19:
    v21 = &v6[-2 * v20];
    v22 = _mm_sub_epi16(
            _mm_loadu_si128((const __m128i *)&v21[2 * v3 - 30]),
            _mm_loadu_si128((const __m128i *)(v21 - 30)));
    *(__m128i *)&v21[2 * v3 - 14] = _mm_sub_epi16(
                                      _mm_loadu_si128((const __m128i *)&v21[2 * v3 - 14]),
                                      _mm_loadu_si128((const __m128i *)(v21 - 14)));
    *(__m128i *)&v21[2 * v3 - 30] = v22;
    goto LABEL_20;
  }
  v12 = v6 - 14;
  v13 = (__int64)&v6[2 * v3 - 14];
  v14 = 0LL;
  v15 = v8 + 1 - (((_BYTE)v8 + 1) & 1);
  do
  {
    v16 = _mm_loadu_si128((const __m128i *)(v13 + 2 * v14 - 48));
    v17 = _mm_loadu_si128((const __m128i *)(v13 + 2 * v14 - 32));
    v18 = _mm_sub_epi16(
            _mm_loadu_si128((const __m128i *)(v13 + 2 * v14 - 16)),
            _mm_loadu_si128((const __m128i *)&v12[2 * v14 - 16]));
    *(__m128i *)(v13 + 2 * v14) = _mm_sub_epi16(
                                    _mm_loadu_si128((const __m128i *)(v13 + 2 * v14)),
                                    _mm_loadu_si128((const __m128i *)&v12[2 * v14]));
    *(__m128i *)(v13 + 2 * v14 - 16) = v18;
    v19 = _mm_sub_epi16(v16, _mm_loadu_si128((const __m128i *)&v12[2 * v14 - 48]));
    *(__m128i *)(v13 + 2 * v14 - 32) = _mm_sub_epi16(v17, _mm_loadu_si128((const __m128i *)&v12[2 * v14 - 32]));
    *(__m128i *)(v13 + 2 * v14 - 48) = v19;
    v14 -= 32LL;
    v15 -= 2LL;
  }
  while ( v15 );
  v20 = -v14;
  if ( (((_BYTE)v8 + 1) & 1) != 0 )
    goto LABEL_19;
LABEL_20:
  v6 -= 2 * ((v3 - 4) & 0xFFFFFFFFFFFFFFF0LL);
  v11 = v3 - 4 - v9;
  if ( v7 != v9 )
  {
    do
    {
LABEL_21:
      *(_WORD *)&v6[2 * v3] -= *(_WORD *)v6;
      v6 -= 2;
      v10 = (v11 - 1 < 0) ^ __OFADD__(-1LL, v11) | (v11 == 1);
      --v11;
    }
    while ( !v10 );
  }
LABEL_6:
  *(_WORD *)&v6[2 * v3] -= *(_WORD *)v6;
  v6 -= 2;
LABEL_7:
  *(_WORD *)&v6[2 * v3] -= *(_WORD *)v6;
  v6 -= 2;
LABEL_8:
  *(_WORD *)&v6[2 * v3] -= *(_WORD *)v6;
  v6 -= 2;
LABEL_9:
  *(_WORD *)&v6[2 * v3] -= *(_WORD *)v6;
  v6 -= 2;
  while ( 1 )
  {
    v10 = v5 <= v3;
    v5 -= v3;
    if ( v10 )
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
