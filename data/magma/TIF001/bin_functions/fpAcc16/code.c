int __fastcall fpAcc(TIFF *tif, uint8_t *cp0, tmsize_t cc)
{
  tmsize_t v4;
  signed __int64 v5;
  tmsize_t v6;
  int v7;
  void *v9;
  void *v10;
  __int64 v11;
  unsigned __int64 v12;
  uint8_t *v13;
  tmsize_t v14;
  unsigned __int64 v15;
  uint8_t *v16;
  __int64 v17;
  __int64 v18;
  __int64 v19;
  __m128i v20;
  __m128i v21;
  __m128i v22;
  __m128i v23;
  __m128i v24;
  unsigned __int64 v25;
  uint8_t *v26;
  __m128i v27;
  char v28;
  uint8_t *v29;
  __int64 v30;
  __int64 v31;
  int v32;
  unsigned int v33;
  __int64 v35;
  __int64 v36;
  unsigned __int64 v37;

  v4 = *((_QWORD *)tif->tif_data + 1);
  v5 = (unsigned __int64)tif->tif_dir.td_bitspersample >> 3;
  v6 = cc / v5;
  if ( !(cc % (v5 * v4)) )
  {
    v9 = TIFFmalloc(cc);
    if ( !v9 )
      return 0;
    v10 = v9;
    if ( v4 >= cc )
      goto LABEL_26;
    v11 = v4 - 4;
    v12 = (unsigned __int64)(v4 - 36) >> 5;
    v37 = (v4 - 4) & 0xFFFFFFFFFFFFFFE0LL;
    v36 = ((_BYTE)v12 + 1) & 1;
    v35 = v12 + 1 - v36;
    v13 = cp0;
    v14 = cc;
    if ( (unsigned __int64)v4 <= 4 )
      goto LABEL_12;
LABEL_13:
    if ( v11 <= 0 )
      goto LABEL_7;
    if ( (unsigned __int64)v11 < 0x20 )
    {
      v15 = v4 - 4;
      goto LABEL_22;
    }
    if ( v12 )
    {
      v16 = v13 + 48;
      v17 = (__int64)&v13[v4 + 48];
      v18 = 0LL;
      v19 = v35;
      do
      {
        v20 = _mm_add_epi8(
                _mm_loadu_si128((const __m128i *)(v17 + v18 - 32)),
                _mm_loadu_si128((const __m128i *)&v16[v18 - 32]));
        v21 = _mm_loadu_si128((const __m128i *)(v17 + v18 - 16));
        v22 = _mm_loadu_si128((const __m128i *)(v17 + v18));
        *(__m128i *)&v13[v4 + v18] = _mm_add_epi8(
                                       _mm_loadu_si128((const __m128i *)&v13[v4 + v18]),
                                       _mm_loadu_si128((const __m128i *)&v13[v18]));
        *(__m128i *)(v17 + v18 - 32) = v20;
        v23 = _mm_add_epi8(_mm_loadu_si128((const __m128i *)&v16[v18 - 16]), v21);
        v24 = _mm_add_epi8(_mm_loadu_si128((const __m128i *)&v16[v18]), v22);
        *(__m128i *)(v17 + v18 - 16) = v23;
        *(__m128i *)(v17 + v18) = v24;
        v18 += 64LL;
        v19 -= 2LL;
      }
      while ( v19 );
      if ( v36 )
        goto LABEL_20;
    }
    else
    {
      v18 = 0LL;
      if ( v36 )
      {
LABEL_20:
        v25 = v12;
        v26 = &v13[v18];
        v27 = _mm_add_epi8(
                _mm_loadu_si128((const __m128i *)&v13[v18 + 16]),
                _mm_loadu_si128((const __m128i *)&v13[v18 + 16 + v4]));
        *(__m128i *)&v26[v4] = _mm_add_epi8(
                                 _mm_loadu_si128((const __m128i *)&v13[v18]),
                                 _mm_loadu_si128((const __m128i *)&v13[v18 + v4]));
        *(__m128i *)&v26[v4 + 16] = v27;
        v12 = v25;
      }
    }
    v13 += v37;
    v15 = v4 - 4 - v37;
    if ( v11 != v37 )
    {
      do
      {
LABEL_22:
        v13[v4] += *v13;
        ++v13;
        v28 = ((__int64)(v15 - 1) < 0) ^ __OFADD__(-1LL, v15) | (v15 == 1);
        --v15;
      }
      while ( !v28 );
    }
LABEL_7:
    v13[v4] += *v13;
    ++v13;
LABEL_8:
    v13[v4] += *v13;
    ++v13;
LABEL_9:
    v13[v4] += *v13;
    ++v13;
LABEL_10:
    v13[v4] += *v13;
    ++v13;
    while ( 1 )
    {
      v14 -= v4;
      if ( v14 <= v4 )
        break;
LABEL_12:
      switch ( v4 )
      {
        case 0LL:
          continue;
        case 1LL:
          goto LABEL_10;
        case 2LL:
          goto LABEL_9;
        case 3LL:
          goto LABEL_8;
        case 4LL:
          goto LABEL_7;
        default:
          goto LABEL_13;
      }
    }
LABEL_26:
    TIFFmemcpy(v10, cp0, cc);
    if ( v6 <= 0 )
    {
LABEL_36:
      TIFFfree(v10);
      return 1;
    }
    v29 = cp0 + 1;
    v30 = 0LL;
    if ( (_WORD)v5 )
      goto LABEL_30;
    while ( 1 )
    {
      do
      {
        ++v30;
        v29 += (unsigned __int16)v5;
        if ( v30 == v6 )
          goto LABEL_36;
      }
      while ( !(_WORD)v5 );
LABEL_30:
      if ( (_WORD)v5 == 1 )
        break;
      v33 = v5 - 2;
      v31 = 0LL;
      do
      {
        v29[v31 - 1] = *((_BYTE *)v10 + v30 + v6 * (v33 + 1));
        v29[v31] = *((_BYTE *)v10 + v30 + v6 * v33);
        v31 += 2LL;
        v33 -= 2;
      }
      while ( (unsigned __int16)v5 - (unsigned __int64)(v5 & 1) != v31 );
      v32 = v31;
      if ( (v5 & 1) != 0 )
LABEL_35:
        cp0[v31 + v5 * v30] = *((_BYTE *)v10 + v30 + v6 * (unsigned int)(v5 + ~v32));
    }
    v31 = 0LL;
    v32 = 0;
    goto LABEL_35;
  }
  v7 = 0;
  TIFFErrorExt(tif->tif_clientdata, "fpAcc", "%s", "cc%(bps*stride))!=0");
  return v7;
}
