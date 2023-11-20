int __fastcall ASN1_TYPE_cmp(const ASN1_TYPE *a, const ASN1_TYPE *b)
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
        if ( type == 5 )
        {
          return 0;
        }
        else if ( type == 6 )
        {
          return OBJ_cmp(a->value.object, b->value.object);
        }
        else
        {
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
  int v9;
  int v10;
  unsigned __int8 *p_c;
  ASN1_INTEGER *v12;
  unsigned __int8 **v13;
  const ASN1_VALUE *v14;
  ASN1_BIT_STRING *v15;
  unsigned __int8 **v16;
  __int64 size;
  unsigned __int8 *v18;
  unsigned __int8 c;

  v18 = cout;
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
  v9 = v7 - 1;
  result = 0;
  switch ( v9 )
  {
    case 0:
      result = -1;
      if ( *(_DWORD *)pval == -1 )
        return result;
      if ( it->utype == -4 )
        goto LABEL_16;
      size = it->size;
      if ( *(_DWORD *)pval )
      {
        if ( size <= 0 )
        {
LABEL_16:
          c = *(_DWORD *)pval;
          v10 = 1;
          p_c = &c;
          if ( cout )
            goto LABEL_31;
          return v10;
        }
      }
      else if ( size )
      {
        goto LABEL_16;
      }
      break;
    case 1:
    case 9:
      v12 = (ASN1_INTEGER *)*pval;
      v13 = &v18;
      if ( !cout )
        v13 = 0LL;
      return ossl_i2c_ASN1_INTEGER(v12, v13);
    case 2:
      v15 = (ASN1_BIT_STRING *)*pval;
      v16 = &v18;
      if ( !cout )
        v16 = 0LL;
      return ossl_i2c_ASN1_BIT_STRING(v15, v16);
    case 4:
      return result;
    case 5:
      p_c = (unsigned __int8 *)*((_QWORD *)*pval + 3);
      result = -1;
      if ( !p_c )
        return result;
      v10 = *((_DWORD *)*pval + 5);
      if ( !v10 )
        return result;
      if ( cout )
        goto LABEL_31;
      return v10;
    default:
      v14 = *pval;
      if ( it->size == 2048 && (*((_BYTE *)v14 + 16) & 0x10) != 0 )
      {
        result = -2;
        if ( cout )
        {
          *((_QWORD *)v14 + 1) = cout;
          *(_DWORD *)v14 = 0;
        }
      }
      else
      {
        p_c = (unsigned __int8 *)*((_QWORD *)v14 + 1);
        v10 = *(_DWORD *)v14;
        if ( cout )
        {
LABEL_31:
          if ( v10 )
            memcpy(cout, p_c, v10);
        }
        return v10;
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
  ASN1_BIT_STRING **p_value;
  _QWORD *funcs;
  __int64 (__fastcall *v10)(ASN1_VALUE **, const unsigned __int8 *, _QWORD, _QWORD, char *);
  ASN1_TYPE *v12;
  ASN1_TYPE *v13;
  ASN1_VALUE **v14;
  int v15;
  char *v16;
  void *v17;
  int v18;
  ASN1_BIT_STRING *v19;
  ASN1_BIT_STRING *v20;
  char *v21;
  ASN1_STRING *v22;
  ASN1_STRING *v23;
  const unsigned __int8 *conta;
  char *v25;
  ASN1_TYPE *typ;

  p_value = (ASN1_BIT_STRING **)pval;
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
    v12 = (ASN1_TYPE *)*pval;
    if ( *pval )
    {
      if ( v12->type == utype )
      {
LABEL_8:
        v14 = pval;
        p_value = (ASN1_BIT_STRING **)&v12->value;
        goto LABEL_10;
      }
    }
    else
    {
      v16 = free_cont;
      v12 = (ASN1_TYPE *)ASN1_TYPE_new();
      if ( !v12 )
      {
        v15 = 0;
        ASN1_TYPE_free(0LL);
        return v15;
      }
      *pval = v12;
      free_cont = v16;
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
        typ = v12;
        ERR_new();
        ERR_set_debug("crypto/asn1/tasn_dec.c", 875, "asn1_ex_c2i");
        v18 = 106;
        goto LABEL_44;
      }
      *(_DWORD *)p_value = *cont;
      return 1;
    case 2:
    case 10:
      goto LABEL_15;
    case 3:
      typ = v12;
      v17 = ossl_c2i_ASN1_BIT_STRING(p_value, &conta, len);
      goto LABEL_27;
    case 4:
    case 7:
    case 8:
    case 9:
    case 11:
    case 12:
    case 13:
    case 14:
    case 15:
    case 16:
    case 17:
    case 18:
    case 19:
    case 20:
    case 21:
    case 22:
    case 23:
    case 24:
    case 25:
    case 26:
    case 27:
    case 29:
      goto LABEL_32;
    case 5:
      if ( len )
      {
        typ = v12;
        ERR_new();
        ERR_set_debug("crypto/asn1/tasn_dec.c", 867, "asn1_ex_c2i");
        v18 = 144;
        goto LABEL_44;
      }
      *p_value = (ASN1_BIT_STRING *)1;
      goto LABEL_17;
    case 6:
      typ = v12;
      v17 = ossl_c2i_ASN1_OBJECT((ASN1_OBJECT **)p_value, &conta, len);
LABEL_27:
      v15 = 1;
      if ( !v17 )
        goto err;
      return v15;
    case 28:
      if ( (len & 3) == 0 )
        goto LABEL_32;
      typ = v12;
      ERR_new();
      ERR_set_debug("crypto/asn1/tasn_dec.c", 925, "asn1_ex_c2i");
      v18 = 215;
      goto LABEL_44;
    case 30:
      if ( (len & 1) == 0 )
        goto LABEL_32;
      typ = v12;
      ERR_new();
      ERR_set_debug("crypto/asn1/tasn_dec.c", 921, "asn1_ex_c2i");
      v18 = 214;
      goto LABEL_44;
    default:
      if ( utype == 258 || utype == 266 )
      {
LABEL_15:
        typ = v12;
        if ( ossl_c2i_ASN1_INTEGER(p_value, &conta, len) )
        {
          (*p_value)->type = utype | (*p_value)->type & 0x100;
          v12 = typ;
LABEL_17:
          v15 = 1;
          if ( utype == 5 && v12 )
            v12->value.ptr = 0LL;
          return v15;
        }
        goto err;
      }
LABEL_32:
      v19 = *p_value;
      if ( *p_value )
      {
        v19->type = utype;
        if ( *free_cont )
        {
LABEL_34:
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
        typ = v12;
        v22 = ASN1_STRING_type_new(utype);
        if ( !v22 )
        {
          ERR_new();
          ERR_set_debug("crypto/asn1/tasn_dec.c", 932, "asn1_ex_c2i");
          v18 = 786688;
LABEL_44:
          ERR_set_error(13, v18, 0LL);
          goto err;
        }
        v19 = v22;
        *p_value = v22;
        v12 = typ;
        free_cont = v25;
        if ( *v25 )
          goto LABEL_34;
      }
      typ = v12;
      v23 = v19;
      v15 = 1;
      if ( !ASN1_STRING_set(v19, cont, len) )
      {
        ERR_new();
        ERR_set_debug("crypto/asn1/tasn_dec.c", 948, "asn1_ex_c2i");
        ERR_set_error(13, 786688, 0LL);
        ASN1_STRING_free(v23);
        *p_value = 0LL;
err:
        ASN1_TYPE_free((ASN1_TYPE_1 *)typ);
        v15 = 0;
        if ( v14 )
          *v14 = 0LL;
        return v15;
      }
      break;
  }
  return v15;
}


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
