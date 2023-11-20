int __fastcall horDiff32(TIFF *tif, uint8_t *cp0, tmsize_t cc)
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
  __m128i v15;
  __m128i v16;
  __m128i v17;
  __m128i v18;
  __int64 v19;
  uint8_t *v20;
  __m128i v21;

  v3 = *((_QWORD *)tif->tif_data + 1);
  if ( cc % (4 * v3) )
  {
    v4 = 0;
    TIFFErrorExt(tif->tif_clientdata, "horDiff32", "%s", "(cc%(4*stride))!=0");
    return v4;
  }
  v4 = 1;
  v5 = cc / 4 - v3;
  if ( cc / 4 <= v3 )
    return v4;
  v6 = &cp0[4 * v5 - 4];
  v7 = v3 - 4;
  v8 = (unsigned __int64)(v3 - 12) >> 3;
  v9 = (v3 - 4) & 0xFFFFFFFFFFFFFFF8LL;
  if ( (unsigned __int64)v3 <= 4 )
    goto LABEL_11;
LABEL_12:
  if ( v7 <= 0 )
    goto LABEL_6;
  if ( (unsigned __int64)v7 < 8 )
  {
    v11 = v3 - 4;
    goto LABEL_21;
  }
  if ( !v8 )
  {
    v19 = 0LL;
LABEL_19:
    v20 = &v6[-4 * v19];
    v21 = _mm_sub_epi32(
            _mm_loadu_si128((const __m128i *)&v20[4 * v3 - 28]),
            _mm_loadu_si128((const __m128i *)(v20 - 28)));
    *(__m128i *)&v20[4 * v3 - 12] = _mm_sub_epi32(
                                      _mm_loadu_si128((const __m128i *)&v20[4 * v3 - 12]),
                                      _mm_loadu_si128((const __m128i *)(v20 - 12)));
    *(__m128i *)&v20[4 * v3 - 28] = v21;
    goto LABEL_20;
  }
  v12 = &v6[4 * v3 - 12];
  v13 = 0LL;
  v14 = v8 + 1 - (((_BYTE)v8 + 1) & 1);
  do
  {
    v15 = _mm_loadu_si128((const __m128i *)&v12[4 * v13 - 48]);
    v16 = _mm_loadu_si128((const __m128i *)&v12[4 * v13 - 32]);
    v17 = _mm_sub_epi32(
            _mm_loadu_si128((const __m128i *)&v12[4 * v13 - 16]),
            _mm_loadu_si128((const __m128i *)&v6[4 * v13 - 28]));
    *(__m128i *)&v12[4 * v13] = _mm_sub_epi32(
                                  _mm_loadu_si128((const __m128i *)&v12[4 * v13]),
                                  _mm_loadu_si128((const __m128i *)&v6[4 * v13 - 12]));
    *(__m128i *)&v12[4 * v13 - 16] = v17;
    v18 = _mm_sub_epi32(v15, _mm_loadu_si128((const __m128i *)&v6[4 * v13 - 60]));
    *(__m128i *)&v12[4 * v13 - 32] = _mm_sub_epi32(v16, _mm_loadu_si128((const __m128i *)&v6[4 * v13 - 44]));
    *(__m128i *)&v12[4 * v13 - 48] = v18;
    v13 -= 16LL;
    v14 -= 2LL;
  }
  while ( v14 );
  v19 = -v13;
  if ( (((_BYTE)v8 + 1) & 1) != 0 )
    goto LABEL_19;
LABEL_20:
  v6 -= 4 * ((v3 - 4) & 0xFFFFFFFFFFFFFFF8LL);
  v11 = v3 - 4 - v9;
  if ( v7 != v9 )
  {
    do
    {
LABEL_21:
      *(_DWORD *)&v6[4 * v3] -= *(_DWORD *)v6;
      v6 -= 4;
      v10 = (v11 - 1 < 0) ^ __OFADD__(-1LL, v11) | (v11 == 1);
      --v11;
    }
    while ( !v10 );
  }
LABEL_6:
  *(_DWORD *)&v6[4 * v3] -= *(_DWORD *)v6;
  v6 -= 4;
LABEL_7:
  *(_DWORD *)&v6[4 * v3] -= *(_DWORD *)v6;
  v6 -= 4;
LABEL_8:
  *(_DWORD *)&v6[4 * v3] -= *(_DWORD *)v6;
  v6 -= 4;
LABEL_9:
  *(_DWORD *)&v6[4 * v3] -= *(_DWORD *)v6;
  v6 -= 4;
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
