char *__fastcall X509_NAME_oneline(const X509_NAME *a, char *buf, int len)
{
  char *data;
  const X509_NAME *v4;
  int v5;
  BUF_MEM *v6;
  const OPENSSL_STACK *v7;
  int v8;
  int v9;
  const OPENSSL_STACK *v10;
  int v11;
  const OPENSSL_STACK *v12;
  const X509_NAME_ENTRY_0 *v13;
  int v14;
  const char *v15;
  unsigned int v16;
  ASN1_STRING *value;
  __int64 length;
  unsigned __int8 *v19;
  __m128i v20;
  __m128i v21;
  __m128i v22;
  __int64 v23;
  __int64 v24;
  __m128i v25;
  __m128i v26;
  __m128i v27;
  __m128i v28;
  __m128i v29;
  __m128i v30;
  __m128i v31;
  __m128i v32;
  __m128i v33;
  __m128i v34;
  __m128i v35;
  __int32 v36;
  __int32 v37;
  __int32 v38;
  __int64 v39;
  __m128i si128;
  __int64 v41;
  int v42;
  int v43;
  __int64 v44;
  int v45;
  unsigned int v46;
  char *v47;
  char *v48;
  const X509_NAME_ENTRY_0 *v49;
  unsigned int v50;
  char *v51;
  unsigned __int8 *v52;
  __int64 v53;
  unsigned __int8 v54;
  BUF_MEM *v55;
  int v56;
  int v57;
  char tmp_buf[80];
  const char *s;
  const X509_NAME_ENTRY_0 *ne;
  const X509_NAME *v62;
  int lena;
  __int64 lold;
  char *bufa;
  BUF_MEM *b;
  int prev_set;
  int i;
  __m128i v69;

  data = buf;
  v4 = a;
  if ( buf )
  {
    v5 = len;
    v6 = 0LL;
    if ( !len )
      return 0LL;
    if ( a )
      goto LABEL_4;
LABEL_79:
    if ( v6 )
    {
      data = v6->data;
      CRYPTO_free(v6, "crypto/x509/x509_obj.c", 55);
    }
    strncpy(data, "NO X509_NAME", v5);
    data[v5 - 1] = 0;
    return data;
  }
  v55 = BUF_MEM_new();
  v56 = 196;
  v57 = 786688;
  if ( !v55 )
  {
    v6 = 0LL;
    goto LABEL_93;
  }
  v6 = v55;
  if ( !BUF_MEM_grow(v55, 0xC8uLL) )
    goto LABEL_93;
  *v6->data = 0;
  v5 = 200;
  if ( !a )
    goto LABEL_79;
LABEL_4:
  b = v6;
  bufa = buf;
  v7 = ossl_check_const_X509_NAME_ENTRY_sk_type(a->entries);
  if ( OPENSSL_sk_num(v7) <= 0 )
  {
    v8 = 0;
LABEL_85:
    if ( b )
    {
      data = b->data;
      CRYPTO_free(b, "crypto/x509/x509_obj.c", 189);
      if ( v8 )
        return data;
    }
    else
    {
LABEL_88:
      data = bufa;
      if ( v8 )
        return data;
    }
    *data = 0;
    return data;
  }
  lena = v5;
  lold = 0LL;
  prev_set = -1;
  v8 = 0;
  v62 = a;
  while ( 1 )
  {
    v12 = ossl_check_const_X509_NAME_ENTRY_sk_type(v4->entries);
    v13 = (const X509_NAME_ENTRY_0 *)OPENSSL_sk_value(v12, v8);
    v14 = OBJ_obj2nid(v13->object);
    if ( !v14 || (v15 = OBJ_nid2sn(v14)) == 0LL )
    {
      i2t_ASN1_OBJECT(tmp_buf, 80, v13->object);
      v15 = tmp_buf;
    }
    s = v15;
    v16 = strlen(v15);
    value = v13->value;
    length = (unsigned int)value->length;
    if ( (int)length > 0x100000 )
    {
      v57 = 134;
      v56 = 76;
      v6 = b;
      goto LABEL_93;
    }
    v19 = value->data;
    if ( (length & 3) != 0 || value->type != 27 )
    {
LABEL_52:
      si128 = _mm_load_si128((const __m128i *)&xmmword_611150);
      goto LABEL_53;
    }
    v69 = 0LL;
    v20 = _mm_load_si128((const __m128i *)&xmmword_611180);
    v21 = _mm_load_si128((const __m128i *)&xmmword_611190);
    v22 = _mm_load_si128((const __m128i *)&xmmword_6111A0);
    if ( (int)length <= 0 )
    {
      v36 = 0;
      v37 = 0;
      v38 = 0;
      goto LABEL_51;
    }
    if ( (unsigned int)length < 8 )
    {
      v23 = 0LL;
    }
    else
    {
      v23 = 0LL;
      if ( (unsigned __int64)(length - 1) <= 3 )
      {
        v23 = (unsigned int)length & 0xFFFFFFF8;
        v24 = 0LL;
        v25 = _mm_load_si128((const __m128i *)&xmmword_611170);
        v26 = _mm_load_si128((const __m128i *)&xmmword_611160);
        do
        {
          v27 = _mm_cvtsi32_si128(*(_DWORD *)&v19[v24 + 4]);
          v28 = _mm_cmpeq_epi32(
                  _mm_and_si128(
                    _mm_unpacklo_epi16(_mm_unpacklo_epi8(_mm_cvtsi32_si128(*(_DWORD *)&v19[v24]), v25), v25),
                    v20),
                  (__m128i)0LL);
          v29 = _mm_and_si128(v25, v21);
          if ( (~_mm_cvtsi128_si32(v28) & 1) != 0 )
            v69.m128i_i32[v29.m128i_i64[0]] = 1;
          v30 = _mm_xor_si128(v28, (__m128i)-1LL);
          if ( (_mm_extract_epi16(v30, 2) & 1) != 0 )
            v69.m128i_i32[_mm_shuffle_epi32(v29, 78).m128i_u64[0]] = 1;
          v31 = _mm_unpacklo_epi8(v27, v25);
          v32 = _mm_and_si128(v26, v21);
          if ( (_mm_extract_epi16(v30, 4) & 1) != 0 )
            v69.m128i_i32[v32.m128i_i64[0]] = 1;
          v33 = _mm_unpacklo_epi16(v31, v25);
          if ( (_mm_extract_epi16(v30, 6) & 1) != 0 )
            v69.m128i_i32[_mm_shuffle_epi32(v32, 78).m128i_u64[0]] = 1;
          v34 = _mm_cmpeq_epi32(_mm_and_si128(v33, v20), (__m128i)0LL);
          if ( (~_mm_cvtsi128_si32(v34) & 1) != 0 )
            v69.m128i_i32[v29.m128i_i64[0]] = 1;
          v35 = _mm_xor_si128(v34, (__m128i)-1LL);
          if ( (_mm_extract_epi16(v35, 2) & 1) != 0 )
            v69.m128i_i32[_mm_shuffle_epi32(v29, 78).m128i_u64[0]] = 1;
          if ( (_mm_extract_epi16(v35, 4) & 1) != 0 )
            v69.m128i_i32[v32.m128i_i64[0]] = 1;
          if ( (_mm_extract_epi16(v35, 6) & 1) != 0 )
            v69.m128i_i32[_mm_shuffle_epi32(v32, 78).m128i_u64[0]] = 1;
          v24 += 8LL;
          v25 = _mm_add_epi64(v25, v22);
          v26 = _mm_add_epi64(v26, v22);
        }
        while ( v23 != v24 );
        if ( v23 == length )
          goto LABEL_50;
      }
    }
    v39 = ~v23;
    if ( (length & 1) != 0 )
    {
      if ( v19[v23] )
        v69.m128i_i32[0] = 1;
      v23 |= 1uLL;
    }
    if ( length + v39 )
    {
      do
      {
        if ( v19[v23] )
          v69.m128i_i32[v23 & 3] = 1;
        if ( v19[v23 + 1] )
          v69.m128i_i32[((_BYTE)v23 + 1) & 3] = 1;
        v23 += 2LL;
      }
      while ( length != v23 );
    }
LABEL_50:
    v38 = v69.m128i_i32[0];
    v37 = v69.m128i_i32[1];
    v36 = v69.m128i_i32[2];
LABEL_51:
    if ( v36 | v38 | v37 )
      goto LABEL_52;
    si128 = _mm_load_si128((const __m128i *)&xmmword_6111B0);
LABEL_53:
    v69 = si128;
    if ( (int)length <= 0 )
    {
      v42 = 0;
    }
    else
    {
      v41 = 0LL;
      v42 = 0;
      do
      {
        if ( v69.m128i_i32[v41 & 3] )
        {
          if ( (v19[v41] | 4) == 47 )
            v42 += 2;
          else
            v42 += 3 * ((unsigned __int8)(v19[v41] - 32) > 0x5Eu) + 1;
        }
        ++v41;
      }
      while ( length != v41 );
    }
    ne = v13;
    v43 = lold + v42;
    v44 = v16 + v43 + 2;
    if ( (int)v44 > 0x100000 )
    {
      v57 = 134;
      v56 = 135;
      v6 = b;
      goto LABEL_93;
    }
    v45 = v8;
    v6 = b;
    if ( !b )
    {
      v47 = bufa;
      v8 = v45;
      if ( (int)v44 >= lena )
        goto LABEL_88;
      goto LABEL_66;
    }
    v46 = v16;
    if ( !BUF_MEM_grow(b, (int)(v16 + v43 + 3)) )
      break;
    v47 = v6->data;
    v8 = v45;
    v16 = v46;
LABEL_66:
    i = v8;
    v48 = &v47[(int)lold];
    v49 = ne;
    *v48 = (4 * (prev_set != ne->set)) | 0x2B;
    v50 = v16;
    memcpy(v48 + 1, s, v16);
    v51 = &v48[v50 + 2];
    v48[v50 + 1] = 61;
    if ( (int)length <= 0 )
    {
      v4 = v62;
      v9 = i;
    }
    else
    {
      v52 = v49->value->data;
      v53 = 0LL;
      v4 = v62;
      v9 = i;
      do
      {
        if ( v69.m128i_i32[v53 & 3] )
        {
          v54 = v52[v53];
          if ( (unsigned __int8)(v54 - 32) >= 0x5Fu )
          {
            *(_WORD *)v51 = 30812;
            v51[2] = Hex_0[(unsigned __int64)v54 >> 4];
            v51[3] = Hex_0[v54 & 0xF];
            v51 += 4;
          }
          else
          {
            if ( (v54 | 4) == 47 )
              *v51++ = 92;
            *v51++ = v54;
          }
        }
        ++v53;
      }
      while ( length != v53 );
    }
    *v51 = 0;
    prev_set = ne->set;
    v8 = v9 + 1;
    v10 = ossl_check_const_X509_NAME_ENTRY_sk_type(v4->entries);
    v11 = OPENSSL_sk_num(v10);
    lold = v44;
    if ( v8 >= v11 )
      goto LABEL_85;
  }
  v57 = 786688;
  v56 = 196;
LABEL_93:
  ERR_new();
  ERR_set_debug("crypto/x509/x509_obj.c", v56, "X509_NAME_oneline");
  data = 0LL;
  ERR_set_error(11, v57, 0LL);
  BUF_MEM_free(v6);
  return data;
}
