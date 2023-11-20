int __fastcall ASN1_TYPE_cmp(const ASN1_TYPE_0 *a, const ASN1_TYPE_0 *b)
{
  int result;
  int type;

  result = -1;
  if ( a )
  {
    if ( b )
    {
      type = a->type;
      if ( a->type == b->type )
      {
        switch ( type )
        {
          case 1:
            return a->value.boolean - b->value.boolean;
          case 5:
            return 0;
          case 6:
            return OBJ_cmp(a->value.object, b->value.object);
          default:
            return ASN1_STRING_cmp(a->value.asn1_string, b->value.asn1_string);
        }
      }
    }
  }
  return result;
}


int __fastcall asn1_ex_i2c(const ASN1_VALUE **pval, unsigned __int8 *cout, int *putype, const ASN1_ITEM *it)
{
  _QWORD *funcs;
  __int64 (__fastcall *v5)(const ASN1_VALUE **, unsigned __int8 *, int *);
  int result;
  int v7;
  char *v8;
  ASN1_INTEGER *v9;
  unsigned __int8 **v10;
  int v11;
  unsigned __int8 *p_c;
  ASN1_BIT_STRING *v13;
  unsigned __int8 **v14;
  const ASN1_VALUE *v15;
  __int64 size;
  unsigned __int8 *v17;
  unsigned __int8 c;

  v17 = cout;
  funcs = it->funcs;
  if ( funcs )
  {
    v5 = (__int64 (__fastcall *)(const ASN1_VALUE **, unsigned __int8 *, int *))funcs[6];
    if ( v5 )
      return v5(pval, cout, putype);
  }
  if ( !it->itype && it->utype == 1 )
    goto LABEL_12;
  if ( !*pval )
    return -1;
  if ( it->itype == 5 )
  {
    v7 = *((_DWORD *)*pval + 1);
    *putype = v7;
    goto LABEL_13;
  }
  if ( it->utype == -4 )
  {
    v8 = (char *)*pval;
    v7 = *(_DWORD *)v8;
    *putype = *(_DWORD *)v8;
    pval = (const ASN1_VALUE **)(v8 + 8);
  }
  else
  {
LABEL_12:
    v7 = *putype;
  }
LABEL_13:
  result = 0;
  switch ( v7 )
  {
    case 1:
      result = -1;
      if ( *(_DWORD *)pval == -1 )
        return result;
      if ( it->utype == -4 )
        goto LABEL_19;
      size = it->size;
      if ( *(_DWORD *)pval )
      {
        if ( size <= 0 )
        {
LABEL_19:
          c = *(_DWORD *)pval;
          v11 = 1;
          p_c = &c;
          if ( cout )
            goto LABEL_31;
          return v11;
        }
      }
      else if ( size )
      {
        goto LABEL_19;
      }
      break;
    case 2:
    case 10:
      v9 = (ASN1_INTEGER *)*pval;
      v10 = &v17;
      if ( !cout )
        v10 = 0LL;
      return ossl_i2c_ASN1_INTEGER(v9, v10);
    case 3:
      v13 = (ASN1_BIT_STRING *)*pval;
      v14 = &v17;
      if ( !cout )
        v14 = 0LL;
      return ossl_i2c_ASN1_BIT_STRING(v13, v14);
    case 5:
      return result;
    case 6:
      p_c = (unsigned __int8 *)*((_QWORD *)*pval + 3);
      result = -1;
      if ( !p_c )
        return result;
      v11 = *((_DWORD *)*pval + 5);
      if ( !v11 )
        return result;
      if ( cout )
        goto LABEL_31;
      return v11;
    default:
      v15 = *pval;
      if ( it->size == 2048 && (*((_BYTE *)v15 + 16) & 0x10) != 0 )
      {
        result = -2;
        if ( cout )
        {
          *((_QWORD *)v15 + 1) = cout;
          *(_DWORD *)v15 = 0;
        }
      }
      else
      {
        p_c = (unsigned __int8 *)*((_QWORD *)v15 + 1);
        v11 = *(_DWORD *)v15;
        if ( cout )
        {
LABEL_31:
          if ( v11 )
            memcpy(cout, p_c, v11);
        }
        return v11;
      }
      return result;
  }
  return result;
}


int __fastcall asn1_ex_c2i(
        ASN1_VALUE **pval,
        const unsigned __int8 *cont,
        int len,
        int utype,
        char *free_cont,
        const ASN1_ITEM *it)
{
  ASN1_INTEGER **p_value;
  _QWORD *funcs;
  __int64 (__fastcall *v10)(ASN1_VALUE **, const unsigned __int8 *, _QWORD, _QWORD, char *);
  ASN1_TYPE_0 *v12;
  ASN1_TYPE_0 *v13;
  ASN1_VALUE **v14;
  char *v15;
  int v16;
  void *v17;
  int v18;
  ASN1_INTEGER *v19;
  ASN1_INTEGER *v20;
  char *v21;
  ASN1_STRING *v22;
  ASN1_STRING *v23;
  const unsigned __int8 *conta;
  char *v25;
  ASN1_TYPE *typ;

  p_value = (ASN1_INTEGER **)pval;
  conta = cont;
  funcs = it->funcs;
  if ( funcs )
  {
    v10 = (__int64 (__fastcall *)(ASN1_VALUE **, const unsigned __int8 *, _QWORD, _QWORD, char *))funcs[5];
    if ( v10 )
      return v10(pval, cont, (unsigned int)len, (unsigned int)utype, free_cont);
  }
  v12 = 0LL;
  if ( it->utype == -4 )
  {
    v12 = (ASN1_TYPE_0 *)*pval;
    if ( *pval )
    {
      if ( v12->type == utype )
      {
LABEL_8:
        v14 = pval;
        p_value = (ASN1_INTEGER **)&v12->value;
        goto LABEL_10;
      }
    }
    else
    {
      v15 = free_cont;
      v12 = (ASN1_TYPE_0 *)ASN1_TYPE_new();
      if ( !v12 )
      {
        v16 = 0;
        ASN1_TYPE_free(0LL);
        return v16;
      }
      *pval = v12;
      free_cont = v15;
      if ( v12->type == utype )
        goto LABEL_8;
    }
    v13 = v12;
    v25 = free_cont;
    ASN1_TYPE_set(v12, utype, 0LL);
    free_cont = v25;
    v12 = v13;
    goto LABEL_8;
  }
  v14 = 0LL;
LABEL_10:
  switch ( utype )
  {
    case 1:
      if ( len != 1 )
      {
        typ = (ASN1_TYPE *)v12;
        ERR_new();
        ERR_set_debug("crypto/asn1/tasn_dec.c", 875, "asn1_ex_c2i");
        v18 = 106;
        goto LABEL_42;
      }
      *(_DWORD *)p_value = *cont;
      return 1;
    case 2:
    case 10:
      typ = (ASN1_TYPE *)v12;
      if ( !ossl_c2i_ASN1_INTEGER(p_value, &conta, len) )
        goto err;
      (*p_value)->type = utype | (*p_value)->type & 0x100;
      v12 = (ASN1_TYPE_0 *)typ;
      goto LABEL_38;
    case 3:
      typ = (ASN1_TYPE *)v12;
      v17 = ossl_c2i_ASN1_BIT_STRING(p_value, &conta, len);
      goto LABEL_22;
    case 5:
      if ( len )
      {
        typ = (ASN1_TYPE *)v12;
        ERR_new();
        ERR_set_debug("crypto/asn1/tasn_dec.c", 867, "asn1_ex_c2i");
        v18 = 144;
        goto LABEL_42;
      }
      *p_value = (ASN1_INTEGER *)1;
LABEL_38:
      v16 = 1;
      if ( utype == 5 && v12 )
        v12->value.ptr = 0LL;
      return v16;
    case 6:
      typ = (ASN1_TYPE *)v12;
      v17 = ossl_c2i_ASN1_OBJECT((ASN1_OBJECT **)p_value, &conta, len);
LABEL_22:
      v16 = 1;
      if ( !v17 )
        goto err;
      return v16;
    case 28:
      if ( (len & 3) == 0 )
        goto LABEL_27;
      typ = (ASN1_TYPE *)v12;
      ERR_new();
      ERR_set_debug("crypto/asn1/tasn_dec.c", 925, "asn1_ex_c2i");
      v18 = 215;
      goto LABEL_42;
    case 30:
      if ( (len & 1) == 0 )
        goto LABEL_27;
      typ = (ASN1_TYPE *)v12;
      ERR_new();
      ERR_set_debug("crypto/asn1/tasn_dec.c", 921, "asn1_ex_c2i");
      v18 = 214;
      goto LABEL_42;
    default:
LABEL_27:
      v19 = *p_value;
      if ( *p_value )
      {
        v19->type = utype;
        if ( *free_cont )
        {
LABEL_29:
          v20 = v19;
          v21 = free_cont;
          CRYPTO_free(v19->data, "crypto/asn1/tasn_dec.c", 942);
          v20->data = (unsigned __int8 *)cont;
          v20->length = len;
          *v21 = 0;
          return 1;
        }
      }
      else
      {
        v25 = free_cont;
        typ = (ASN1_TYPE *)v12;
        v22 = ASN1_STRING_type_new(utype);
        if ( !v22 )
        {
          ERR_new();
          ERR_set_debug("crypto/asn1/tasn_dec.c", 932, "asn1_ex_c2i");
          v18 = 786688;
LABEL_42:
          ERR_set_error(13, v18, 0LL);
          goto err;
        }
        v19 = v22;
        *p_value = v22;
        v12 = (ASN1_TYPE_0 *)typ;
        free_cont = v25;
        if ( *v25 )
          goto LABEL_29;
      }
      typ = (ASN1_TYPE *)v12;
      v23 = v19;
      v16 = 1;
      if ( ASN1_STRING_set(v19, cont, len) )
        return v16;
      ERR_new();
      ERR_set_debug("crypto/asn1/tasn_dec.c", 948, "asn1_ex_c2i");
      ERR_set_error(13, 786688, 0LL);
      ASN1_STRING_free(v23);
      *p_value = 0LL;
err:
      ASN1_TYPE_free((ASN1_TYPE_2 *)typ);
      v16 = 0;
      if ( v14 )
        *v14 = 0LL;
      break;
  }
  return v16;
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
