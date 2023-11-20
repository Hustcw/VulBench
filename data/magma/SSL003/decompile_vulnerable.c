int __fastcall asn1_d2i_read_bio(BIO *in, BUF_MEM **pb)
{
  BUF_MEM *v2;
  BUF_MEM *v3;
  __int64 v4;
  __int64 v5;
  __int64 v6;
  __int64 v7;
  __int64 v8;
  int v9;
  bool v10;
  char *v11;
  __int64 v12;
  const unsigned __int8 *v13;
  char *data;
  char object;
  unsigned __int64 error;
  int v17;
  unsigned __int64 v18;
  size_t v19;
  size_t v20;
  size_t v21;
  int v22;
  int v23;
  int v24;
  int v25;
  int v27;
  int xclass;
  size_t want;
  BUF_MEM **pba;
  __int64 slen;
  BIO *ina;
  int tag;
  const unsigned __int8 *q;
  __int64 eos;
  BUF_MEM *str;

  ina = in;
  v2 = BUF_MEM_new();
  if ( !v2 )
  {
    ERR_new();
    ERR_set_debug("crypto/asn1/a_d2i_fp.c", 126, "asn1_d2i_read_bio");
    ERR_set_error(13, 786688, 0LL);
LABEL_50:
    LODWORD(v7) = -1;
    return v7;
  }
  v3 = v2;
  pba = pb;
  ERR_set_mark();
  v4 = 0LL;
  v5 = 0LL;
  v6 = 0LL;
  str = v3;
LABEL_3:
  while ( 2 )
  {
    eos = v4;
    v7 = v5;
    while ( 1 )
    {
      v8 = v6 - v7;
      if ( (unsigned __int64)(v6 - v7) >= 9 )
      {
        data = v3->data;
        v12 = v7;
        v13 = (const unsigned __int8 *)&data[v7];
        q = v13;
      }
      else
      {
        if ( __CFADD__(v6, 8 - v8) || !BUF_MEM_grow_clean(v3, v7 + 8) )
        {
          ERR_new();
          v27 = 137;
LABEL_54:
          ERR_set_debug("crypto/asn1/a_d2i_fp.c", v27, "asn1_d2i_read_bio");
          v25 = 786688;
          goto LABEL_48;
        }
        v9 = BIO_read(ina, &v3->data[v6], 8 - v8);
        if ( !v8 && v9 < 0 )
        {
          ERR_new();
          v24 = 142;
LABEL_47:
          ERR_set_debug("crypto/asn1/a_d2i_fp.c", v24, "asn1_d2i_read_bio");
          v25 = 142;
          goto LABEL_48;
        }
        if ( v9 > 0 )
        {
          v10 = __CFADD__(v9, v6);
          v6 += v9;
          if ( v10 )
          {
            ERR_new();
            v23 = 147;
LABEL_60:
            ERR_set_debug("crypto/asn1/a_d2i_fp.c", v23, "asn1_d2i_read_bio");
            v25 = 155;
LABEL_48:
            ERR_set_error(13, v25, 0LL);
err:
            ERR_clear_last_mark();
            BUF_MEM_free(str);
            goto LABEL_50;
          }
          v8 = v6 - v7;
        }
        v11 = v3->data;
        v12 = v7;
        v13 = (const unsigned __int8 *)&v11[v7];
        q = v13;
        if ( !v8 )
          goto err;
      }
      object = ASN1_get_object(&q, &slen, &tag, &xclass, v8);
      if ( object < 0 )
      {
        error = ERR_peek_last_error();
        if ( ERR_GET_REASON_1(error) != 155 )
          goto err;
        ERR_pop_to_mark();
      }
      v5 = v12 + (int)q - (int)v13;
      if ( (object & 1) != 0 )
      {
        if ( (_DWORD)eos != -1 )
        {
          v4 = (unsigned int)(eos + 1);
          v3 = str;
          goto LABEL_3;
        }
        ERR_new();
        ERR_set_debug("crypto/asn1/a_d2i_fp.c", 175, "asn1_d2i_read_bio");
        v25 = 123;
        goto LABEL_48;
      }
      v17 = eos;
      if ( (_DWORD)eos )
      {
        if ( !slen && !tag )
          break;
      }
      v18 = slen - (v6 - v5);
      if ( slen > (unsigned __int64)(v6 - v5) )
      {
        if ( v18 > 0x7FFFFFFF || v18 > ~v6 )
        {
          ERR_new();
          v23 = 199;
        }
        else
        {
          v19 = slen - (v6 - v5);
          if ( !v18 )
            goto LABEL_26;
          do
          {
            v20 = v19;
            if ( v19 > v18 )
              v20 = v18;
            if ( !BUF_MEM_grow_clean(str, v20 + v6) )
            {
              ERR_new();
              v27 = 212;
              goto LABEL_54;
            }
            want = v19;
            if ( v20 )
            {
              v21 = v20;
              while ( 1 )
              {
                v22 = BIO_read(ina, &str->data[v6], v21);
                if ( v22 <= 0 )
                  break;
                v6 += v22;
                v21 -= v22;
                if ( !v21 )
                  goto LABEL_29;
              }
              ERR_new();
              v24 = 229;
              goto LABEL_47;
            }
LABEL_29:
            v19 = want - v20;
            v18 <<= v18 < 0x3FFFFFFF;
            v17 = eos;
          }
          while ( want != v20 );
          v7 = v5 + slen;
          if ( !__CFADD__(v5, slen) )
            goto LABEL_27;
LABEL_55:
          ERR_new();
          v23 = 244;
        }
        goto LABEL_60;
      }
LABEL_26:
      v7 = v5 + slen;
      if ( __CFADD__(v5, slen) )
        goto LABEL_55;
LABEL_27:
      v3 = str;
      if ( !v17 )
        goto LABEL_43;
    }
    v7 = v12 + (int)q - (int)v13;
    v4 = (unsigned int)(eos - 1);
    v3 = str;
    if ( (_DWORD)eos != 1 )
      continue;
    break;
  }
LABEL_43:
  if ( (v7 & 0xFFFFFFFF80000000LL) != 0 )
  {
    ERR_new();
    v23 = 256;
    goto LABEL_60;
  }
  *pba = v3;
  return v7;
}
