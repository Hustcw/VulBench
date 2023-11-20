int __fastcall fpAcc(TIFF *tif, uint8_t *cp0, tmsize_t cc)
{
  tmsize_t v5;
  signed __int64 v6;
  tmsize_t v7;
  void *v8;
  void *v9;
  __int64 v10;
  unsigned __int64 v11;
  uint8_t *v12;
  tmsize_t v13;
  unsigned __int64 v14;
  uint8_t *v15;
  __int64 v16;
  __int64 v17;
  __int64 v18;
  __m128i v19;
  __m128i v20;
  __m128i v21;
  __m128i v22;
  __m128i v23;
  unsigned __int64 v24;
  uint8_t *v25;
  __m128i v26;
  char v27;
  uint8_t *v28;
  __int64 v29;
  __int64 v30;
  int v31;
  unsigned int v32;
  __int64 v34;
  __int64 v35;
  unsigned __int64 v36;

  v5 = *((_QWORD *)tif->tif_data + 1);
  v6 = (unsigned __int64)tif->tif_dir.td_bitspersample >> 3;
  v7 = cc / v6;
  v8 = TIFFmalloc(cc);
  if ( !v8 )
    return 0;
  v9 = v8;
  if ( v5 < cc )
  {
    v10 = v5 - 4;
    v11 = (unsigned __int64)(v5 - 36) >> 5;
    v36 = (v5 - 4) & 0xFFFFFFFFFFFFFFE0LL;
    v35 = ((_BYTE)v11 + 1) & 1;
    v34 = v11 + 1 - v35;
    v12 = cp0;
    v13 = cc;
    if ( (unsigned __int64)v5 <= 4 )
      goto LABEL_10;
LABEL_11:
    if ( v10 <= 0 )
      goto LABEL_5;
    if ( (unsigned __int64)v10 < 0x20 )
    {
      v14 = v5 - 4;
      do
      {
LABEL_20:
        v12[v5] += *v12;
        ++v12;
        v27 = ((__int64)(v14 - 1) < 0) ^ __OFADD__(-1LL, v14) | (v14 == 1);
        --v14;
      }
      while ( !v27 );
LABEL_5:
      v12[v5] += *v12;
      ++v12;
LABEL_6:
      v12[v5] += *v12;
      ++v12;
LABEL_7:
      v12[v5] += *v12;
      ++v12;
LABEL_8:
      v12[v5] += *v12;
      ++v12;
      while ( 1 )
      {
        v13 -= v5;
        if ( v13 <= v5 )
          goto LABEL_24;
LABEL_10:
        switch ( v5 )
        {
          case 0LL:
            continue;
          case 1LL:
            goto LABEL_8;
          case 2LL:
            goto LABEL_7;
          case 3LL:
            goto LABEL_6;
          case 4LL:
            goto LABEL_5;
          default:
            goto LABEL_11;
        }
      }
    }
    if ( v11 )
    {
      v15 = v12 + 48;
      v16 = (__int64)&v12[v5 + 48];
      v17 = 0LL;
      v18 = v34;
      do
      {
        v19 = _mm_add_epi8(
                _mm_loadu_si128((const __m128i *)(v16 + v17 - 32)),
                _mm_loadu_si128((const __m128i *)&v15[v17 - 32]));
        v20 = _mm_loadu_si128((const __m128i *)(v16 + v17 - 16));
        v21 = _mm_loadu_si128((const __m128i *)(v16 + v17));
        *(__m128i *)&v12[v5 + v17] = _mm_add_epi8(
                                       _mm_loadu_si128((const __m128i *)&v12[v5 + v17]),
                                       _mm_loadu_si128((const __m128i *)&v12[v17]));
        *(__m128i *)(v16 + v17 - 32) = v19;
        v22 = _mm_add_epi8(_mm_loadu_si128((const __m128i *)&v15[v17 - 16]), v20);
        v23 = _mm_add_epi8(_mm_loadu_si128((const __m128i *)&v15[v17]), v21);
        *(__m128i *)(v16 + v17 - 16) = v22;
        *(__m128i *)(v16 + v17) = v23;
        v17 += 64LL;
        v18 -= 2LL;
      }
      while ( v18 );
      if ( v35 )
        goto LABEL_18;
    }
    else
    {
      v17 = 0LL;
      if ( v35 )
      {
LABEL_18:
        v24 = v11;
        v25 = &v12[v17];
        v26 = _mm_add_epi8(
                _mm_loadu_si128((const __m128i *)&v12[v17 + 16]),
                _mm_loadu_si128((const __m128i *)&v12[v17 + 16 + v5]));
        *(__m128i *)&v25[v5] = _mm_add_epi8(
                                 _mm_loadu_si128((const __m128i *)&v12[v17]),
                                 _mm_loadu_si128((const __m128i *)&v12[v17 + v5]));
        *(__m128i *)&v25[v5 + 16] = v26;
        v11 = v24;
      }
    }
    v12 += v36;
    v14 = v5 - 4 - v36;
    if ( v10 == v36 )
      goto LABEL_5;
    goto LABEL_20;
  }
LABEL_24:
  TIFFmemcpy(v9, cp0, cc);
  if ( v7 > 0 )
  {
    v28 = cp0 + 1;
    v29 = 0LL;
    if ( (_WORD)v6 )
      goto LABEL_28;
    while ( 1 )
    {
      do
      {
        ++v29;
        v28 += (unsigned __int16)v6;
        if ( v29 == v7 )
          goto LABEL_34;
      }
      while ( !(_WORD)v6 );
LABEL_28:
      if ( (_WORD)v6 == 1 )
        break;
      v32 = v6 - 2;
      v30 = 0LL;
      do
      {
        v28[v30 - 1] = *((_BYTE *)v9 + v29 + v7 * (v32 + 1));
        v28[v30] = *((_BYTE *)v9 + v29 + v7 * v32);
        v30 += 2LL;
        v32 -= 2;
      }
      while ( (unsigned __int16)v6 - (unsigned __int64)(v6 & 1) != v30 );
      v31 = v30;
      if ( (v6 & 1) != 0 )
LABEL_33:
        cp0[v30 + v6 * v29] = *((_BYTE *)v9 + v29 + v7 * (unsigned int)(v6 + ~v31));
    }
    v30 = 0LL;
    v31 = 0;
    goto LABEL_33;
  }
LABEL_34:
  TIFFfree(v9);
  return 1;
}
