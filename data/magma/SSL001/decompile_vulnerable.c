size_t __fastcall i2c_ibuf(const unsigned __int8 *b, size_t blen, int neg, unsigned __int8 **pp)
{
  const unsigned __int8 *v5;
  unsigned int v6;
  size_t v7;
  size_t v8;
  char v9;
  size_t v10;
  __int64 v11;
  unsigned __int64 v12;
  unsigned __int64 v13;
  __int64 v14;
  __m128i v15;
  __m128i v16;
  __int64 v17;
  __m128i v18;
  __m128i v19;
  unsigned __int8 *v20;
  unsigned __int8 *v21;
  unsigned __int64 v22;
  unsigned __int8 v23;
  __int64 v24;
  unsigned __int8 *v25;
  _BYTE *v26;
  unsigned __int64 v27;
  unsigned __int64 v28;
  __int64 v29;
  __m128i si128;
  __m128i v31;
  __m128i v32;
  __m128i v33;
  unsigned __int64 v34;
  unsigned __int64 v35;
  __int64 v36;
  __int64 v37;

  v5 = b;
  v6 = 0;
  v7 = 1LL;
  LOBYTE(b) = 0;
  v8 = 0LL;
  if ( v5 && blen )
  {
    v9 = *v5;
    if ( !neg )
    {
      LOBYTE(b) = 0;
      v6 = *(char *)v5 < 0;
LABEL_21:
      v7 = blen + v6;
      v8 = blen;
      goto LABEL_22;
    }
    LOBYTE(b) = -1;
    v6 = 1;
    if ( (unsigned __int8)v9 > 0x80u )
      goto LABEL_21;
    v6 = 0;
    if ( v9 != (char)0x80 )
      goto LABEL_21;
    LODWORD(b) = 0;
    if ( blen < 2 )
    {
LABEL_20:
      v6 = (unsigned __int8)b & 1;
      goto LABEL_21;
    }
    v10 = blen - 1;
    v11 = 1LL;
    if ( blen - 1 >= 8 )
    {
      v12 = v10 & 0xFFFFFFFFFFFFFFF8LL;
      if ( (v10 & 0xFFFFFFFFFFFFFFF8LL) == 8 )
      {
        v15 = 0LL;
        v14 = 0LL;
        v16 = 0LL;
      }
      else
      {
        v13 = (((unsigned __int8)(((v10 & 0xFFFFFFFFFFFFFFF8LL) - 8) >> 3) + 1) & 1)
            - ((((v10 & 0xFFFFFFFFFFFFFFF8LL) - 8) >> 3)
             + 1);
        v14 = 0LL;
        v15 = 0LL;
        v16 = 0LL;
        do
        {
          v15 = _mm_or_si128(
                  _mm_unpacklo_epi16(
                    _mm_unpacklo_epi8(_mm_cvtsi32_si128(*(_DWORD *)&v5[v14 + 9]), (__m128i)0LL),
                    (__m128i)0LL),
                  _mm_or_si128(
                    _mm_unpacklo_epi16(
                      _mm_unpacklo_epi8(_mm_cvtsi32_si128(*(_DWORD *)&v5[v14 + 1]), (__m128i)0LL),
                      (__m128i)0LL),
                    v15));
          v16 = _mm_or_si128(
                  _mm_unpacklo_epi16(
                    _mm_unpacklo_epi8(_mm_cvtsi32_si128(*(_DWORD *)&v5[v14 + 13]), (__m128i)0LL),
                    (__m128i)0LL),
                  _mm_or_si128(
                    _mm_unpacklo_epi16(
                      _mm_unpacklo_epi8(_mm_cvtsi32_si128(*(_DWORD *)&v5[v14 + 5]), (__m128i)0LL),
                      (__m128i)0LL),
                    v16));
          v14 += 16LL;
          v13 += 2LL;
        }
        while ( v13 );
      }
      if ( (((unsigned __int8)(((v10 & 0xFFFFFFFFFFFFFFF8LL) - 8) >> 3) + 1) & 1) != 0 )
      {
        v17 = v14 | 1;
        v16 = _mm_or_si128(
                v16,
                _mm_unpacklo_epi16(
                  _mm_unpacklo_epi8(_mm_cvtsi32_si128(*(_DWORD *)&v5[v17 + 4]), (__m128i)0LL),
                  (__m128i)0LL));
        v15 = _mm_or_si128(
                v15,
                _mm_unpacklo_epi16(
                  _mm_unpacklo_epi8(_mm_cvtsi32_si128(*(_DWORD *)&v5[v17]), (__m128i)0LL),
                  (__m128i)0LL));
      }
      v18 = _mm_or_si128(v15, v16);
      v19 = _mm_or_si128(_mm_shuffle_epi32(v18, 78), v18);
      LODWORD(b) = _mm_cvtsi128_si32(_mm_or_si128(_mm_shuffle_epi32(v19, 229), v19));
      if ( v10 == v12 )
        goto LABEL_19;
      v11 = v12 | 1;
    }
    do
      LODWORD(b) = v5[v11++] | (unsigned int)b;
    while ( blen != v11 );
LABEL_19:
    LOBYTE(b) = -((_DWORD)b != 0);
    goto LABEL_20;
  }
LABEL_22:
  if ( pp )
  {
    v20 = *pp;
    if ( *pp )
    {
      *v20 = (unsigned __int8)b;
      v21 = &v20[v6];
      if ( v8 )
      {
        if ( neg )
        {
          v22 = v8 - 1;
          v23 = v5[v8 - 1];
          if ( v23 )
          {
            v24 = (__int64)&v5[v8];
            v25 = &v21[v8 - 1];
          }
          else
          {
            do
            {
              v21[v22] = 0;
              v23 = v5[--v22];
            }
            while ( !v23 );
            v24 = (__int64)&v5[v22 + 1];
            v25 = &v21[v22];
          }
          *v25 = -v23;
          if ( v22 )
          {
            v26 = (_BYTE *)(v24 - 2);
            if ( v22 >= 0x10 && ((unsigned __int64)&v25[-v22] >= v24 - 1 || v24 + ~v22 >= (unsigned __int64)v25) )
            {
              v27 = v22 & 0xFFFFFFFFFFFFFFF0LL;
              if ( (v22 & 0xFFFFFFFFFFFFFFF0LL) == 16 )
              {
                v29 = 0LL;
              }
              else
              {
                v28 = (((v22 & 0xFFFFFFFFFFFFFFF0LL) - 16) >> 4)
                    + 1
                    - (((unsigned __int8)(((v22 & 0xFFFFFFFFFFFFFFF0LL) - 16) >> 4) + 1) & 1);
                v29 = 0LL;
                si128 = _mm_load_si128((const __m128i *)&xmmword_612D50);
                do
                {
                  *(__m128i *)&v25[v29 - 16] = _mm_packus_epi16(
                                                 _mm_andnot_si128(
                                                   _mm_unpacklo_epi8(
                                                     _mm_loadl_epi64((const __m128i *)(v24 + v29 - 17)),
                                                     si128),
                                                   si128),
                                                 _mm_andnot_si128(
                                                   _mm_unpacklo_epi8(
                                                     _mm_loadl_epi64((const __m128i *)(v24 + v29 - 9)),
                                                     si128),
                                                   si128));
                  *(__m128i *)&v25[v29 - 32] = _mm_packus_epi16(
                                                 _mm_andnot_si128(
                                                   _mm_unpacklo_epi8(
                                                     _mm_loadl_epi64((const __m128i *)(v24 + v29 - 33)),
                                                     si128),
                                                   si128),
                                                 _mm_andnot_si128(
                                                   _mm_unpacklo_epi8(
                                                     _mm_loadl_epi64((const __m128i *)(v24 + v29 - 25)),
                                                     si128),
                                                   si128));
                  v29 -= 32LL;
                  v28 -= 2LL;
                }
                while ( v28 );
              }
              if ( (((unsigned __int8)(((v22 & 0xFFFFFFFFFFFFFFF0LL) - 16) >> 4) + 1) & 1) != 0 )
              {
                v31 = _mm_loadl_epi64((const __m128i *)&v26[v29 - 7]);
                v32 = _mm_unpacklo_epi8(v31, v31);
                v33 = _mm_load_si128((const __m128i *)&xmmword_612D50);
                *(__m128i *)&v25[v29 - 16] = _mm_packus_epi16(
                                               _mm_andnot_si128(
                                                 _mm_unpacklo_epi8(
                                                   _mm_loadl_epi64((const __m128i *)&v26[v29 - 15]),
                                                   v32),
                                                 v33),
                                               _mm_andnot_si128(v32, v33));
              }
              if ( v22 == v27 )
                goto LABEL_50;
              v22 -= v27;
              v26 -= v27;
              v25 -= v27;
            }
            v34 = v22 - 1;
            v35 = v22 & 3;
            if ( (v22 & 3) != 0 )
            {
              do
              {
                *--v25 = ~*v26--;
                --v22;
                --v35;
              }
              while ( v35 );
            }
            if ( v34 >= 3 )
            {
              v36 = -(__int64)v22;
              v37 = 0LL;
              do
              {
                v25[v37 - 1] = ~v26[v37];
                v25[v37 - 2] = ~v26[v37 - 1];
                v25[v37 - 3] = ~v26[v37 - 2];
                v25[v37 - 4] = ~v26[v37 - 3];
                v37 -= 4LL;
              }
              while ( v36 != v37 );
            }
          }
        }
        else
        {
          memcpy(v21, v5, (unsigned int)v8);
        }
      }
      else
      {
        *v21 = 0;
      }
LABEL_50:
      *pp += v7;
    }
  }
  return v7;
}
