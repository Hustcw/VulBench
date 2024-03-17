void __fastcall twos_complement(unsigned __int8 *dst, const unsigned __int8 *src, size_t len, unsigned __int8 pad)
{
  const unsigned __int8 *v4; // rsi
  unsigned __int8 *v5; // rdi
  int v6; // r10d
  size_t v7; // r8
  unsigned __int8 v8; // r9
  unsigned int v9; // r10d
  __int64 v10; // r8
  __int64 v11; // r9
  unsigned int v12; // eax
  unsigned int v13; // r10d

  if ( len )
  {
    v4 = &src[len];
    v5 = &dst[len];
    v6 = pad & 1;
    if ( (len & 1) != 0 )
    {
      v7 = len - 1;
      v8 = pad ^ *--v4;
      v9 = v8 + v6;
      *--v5 = v9;
      v6 = v9 >> 8;
      if ( len == 1 )
        return;
    }
    else
    {
      v7 = len;
      if ( len == 1 )
        return;
    }
    v10 = -(__int64)v7;
    v11 = 0LL;
    do
    {
      v12 = v6 + (unsigned __int8)(pad ^ v4[v11 - 1]);
      v5[v11 - 1] = v12;
      v13 = (v12 >> 8) + (unsigned __int8)(pad ^ v4[v11 - 2]);
      v5[v11 - 2] = v13;
      v6 = v13 >> 8;
      v11 -= 2LL;
    }
    while ( v10 != v11 );
  }
}

size_t __fastcall i2c_ibuf(const unsigned __int8 *b, size_t blen, int neg, unsigned __int8 **pp)
{
  unsigned int v7;
  size_t v8;
  int v9;
  size_t v10;
  unsigned __int8 v11;
  size_t v12;
  __int64 v13;
  unsigned __int64 v14;
  unsigned __int64 v15;
  __int64 v16;
  __m128i v17;
  __m128i v18;
  __m128i v19;
  __m128i v20;
  unsigned __int8 *v21;

  v7 = 0;
  v8 = 1LL;
  LOBYTE(v9) = 0;
  v10 = 0LL;
  if ( b && blen )
  {
    v11 = *b;
    if ( !neg )
    {
      LOBYTE(v9) = 0;
      v7 = *(char *)b < 0;
LABEL_21:
      v8 = blen + v7;
      v10 = blen;
      goto LABEL_22;
    }
    LOBYTE(v9) = -1;
    v7 = 1;
    if ( v11 > 0x80u )
      goto LABEL_21;
    v7 = 0;
    if ( v11 != 0x80 )
      goto LABEL_21;
    v9 = 0;
    if ( blen < 2 )
    {
LABEL_20:
      v7 = v9 & 1;
      goto LABEL_21;
    }
    v12 = blen - 1;
    v13 = 1LL;
    if ( blen - 1 >= 8 )
    {
      v14 = v12 & 0xFFFFFFFFFFFFFFF8LL;
      if ( (v12 & 0xFFFFFFFFFFFFFFF8LL) == 8 )
      {
        v17 = 0LL;
        v16 = 1LL;
        v18 = 0LL;
      }
      else
      {
        v15 = (((unsigned __int8)(((v12 & 0xFFFFFFFFFFFFFFF8LL) - 8) >> 3) + 1) & 1)
            - ((((v12 & 0xFFFFFFFFFFFFFFF8LL) - 8) >> 3)
             + 1);
        v16 = 1LL;
        v17 = 0LL;
        v18 = 0LL;
        do
        {
          v17 = _mm_or_si128(
                  _mm_unpacklo_epi16(
                    _mm_unpacklo_epi8(_mm_cvtsi32_si128(*(_DWORD *)&b[v16 + 8]), (__m128i)0LL),
                    (__m128i)0LL),
                  _mm_or_si128(
                    _mm_unpacklo_epi16(
                      _mm_unpacklo_epi8(_mm_cvtsi32_si128(*(_DWORD *)&b[v16]), (__m128i)0LL),
                      (__m128i)0LL),
                    v17));
          v18 = _mm_or_si128(
                  _mm_unpacklo_epi16(
                    _mm_unpacklo_epi8(_mm_cvtsi32_si128(*(_DWORD *)&b[v16 + 12]), (__m128i)0LL),
                    (__m128i)0LL),
                  _mm_or_si128(
                    _mm_unpacklo_epi16(
                      _mm_unpacklo_epi8(_mm_cvtsi32_si128(*(_DWORD *)&b[v16 + 4]), (__m128i)0LL),
                      (__m128i)0LL),
                    v18));
          v16 += 16LL;
          v15 += 2LL;
        }
        while ( v15 );
      }
      if ( (((unsigned __int8)(((v12 & 0xFFFFFFFFFFFFFFF8LL) - 8) >> 3) + 1) & 1) != 0 )
      {
        v18 = _mm_or_si128(
                v18,
                _mm_unpacklo_epi16(
                  _mm_unpacklo_epi8(_mm_cvtsi32_si128(*(_DWORD *)&b[v16 + 4]), (__m128i)0LL),
                  (__m128i)0LL));
        v17 = _mm_or_si128(
                v17,
                _mm_unpacklo_epi16(_mm_unpacklo_epi8(_mm_cvtsi32_si128(*(_DWORD *)&b[v16]), (__m128i)0LL), (__m128i)0LL));
      }
      v19 = _mm_or_si128(v17, v18);
      v20 = _mm_or_si128(_mm_shuffle_epi32(v19, 78), v19);
      v9 = _mm_cvtsi128_si32(_mm_or_si128(_mm_shuffle_epi32(v20, 229), v20));
      if ( v12 == v14 )
        goto LABEL_19;
      v13 = v14 | 1;
    }
    do
      v9 |= b[v13++];
    while ( blen != v13 );
LABEL_19:
    LOBYTE(v9) = -(v9 != 0);
    goto LABEL_20;
  }
LABEL_22:
  if ( pp )
  {
    v21 = *pp;
    if ( *pp )
    {
      *v21 = v9;
      twos_complement(&v21[v7], b, v10, v9);
      *pp += v8;
    }
  }
  return v8;
}
