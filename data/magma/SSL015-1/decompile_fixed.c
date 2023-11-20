BIO *__fastcall PKCS7_dataInit(PKCS7 *p7, BIO *bio)
{
  const PKCS7_CTX *v3;
  OSSL_LIB_CTX *v4;
  const char *v5;
  const char *v6;
  int v7;
  int v8;
  const EVP_CIPHER *v9;
  const stack_st_X509_ALGOR *v10;
  stack_st_PKCS7_RECIP_INFO *v11;
  X509_ALGOR *v12;
  ASN1_OCTET_STRING *octet_string;
  X509_ALGOR *v14;
  union {char *ptr;ASN1_OCTET_STRING *data;PKCS7_SIGNED *sign;PKCS7_ENVELOPE *enveloped;PKCS7_SIGN_ENVELOPE *signed_and_enveloped;PKCS7_DIGEST *digest;PKCS7_ENCRYPT *encrypted;ASN1_TYPE *other;} v15;
  BIO *v16;
  int v17;
  EVP_CIPHER *v18;
  int v19;
  union {char *ptr;ASN1_OCTET_STRING *data;PKCS7_SIGNED *sign;PKCS7_ENVELOPE *enveloped;PKCS7_SIGN_ENVELOPE *signed_and_enveloped;PKCS7_DIGEST *digest;PKCS7_ENCRYPT *encrypted;ASN1_TYPE *other;} v20;
  __int64 v21;
  _QWORD *ptr;
  __int64 v23;
  union {char *ptr;ASN1_OCTET_STRING *data;PKCS7_SIGNED *sign;PKCS7_ENVELOPE *enveloped;PKCS7_SIGN_ENVELOPE *signed_and_enveloped;PKCS7_DIGEST *digest;PKCS7_ENCRYPT *encrypted;ASN1_TYPE *other;} v24;
  const OPENSSL_STACK *v25;
  int v26;
  X509_ALGOR *v27;
  PKCS7_0 *v28;
  const EVP_CIPHER *v29;
  const BIO_METHOD *v30;
  BIO *v31;
  BIO *v32;
  int iv_length;
  int type;
  OSSL_LIB_CTX *v35;
  const EVP_CIPHER *v36;
  const char *v37;
  ASN1_TYPE *parameter;
  X509_ALGOR *v39;
  const OPENSSL_STACK *v40;
  int v41;
  PKCS7_RECIP_INFO *v42;
  int v43;
  BIO *v44;
  const BIO_METHOD *v45;
  BIO *v46;
  const BIO_METHOD *v47;
  BIO *v48;
  unsigned __int8 key[64];
  unsigned __int8 iv[16];
  const EVP_CIPHER *evp_cipher;
  OSSL_LIB_CTX *libctx;
  const char *propq;
  BIO *bioa;
  ASN1_OCTET_STRING *os;
  stack_st_PKCS7_RECIP_INFO *rsk;
  X509_ALGOR *xalg;
  EVP_CIPHER_CTX_0 *parg;
  X509_ALGOR *keylen;
  BIO *out;
  PKCS7 *p7a;

  out = 0LL;
  if ( !p7 )
  {
    ERR_new();
    ERR_set_debug("crypto/pkcs7/pk7_doit.c", 222, "PKCS7_dataInit");
    v16 = 0LL;
    v17 = 143;
LABEL_7:
    ERR_set_error(33, v17, 0LL);
    return v16;
  }
  v3 = ossl_pkcs7_get0_ctx((const PKCS7_0 *)p7);
  v4 = ossl_pkcs7_ctx_get0_libctx(v3);
  v5 = ossl_pkcs7_ctx_get0_propq(v3);
  if ( !p7->d.ptr )
  {
    ERR_new();
    ERR_set_debug("crypto/pkcs7/pk7_doit.c", 240, "PKCS7_dataInit");
    v16 = 0LL;
    v17 = 122;
    goto LABEL_7;
  }
  v6 = v5;
  v7 = OBJ_obj2nid(p7->type);
  p7->state = 0;
  v8 = v7 - 21;
  p7a = p7;
  propq = v6;
  libctx = v4;
  v9 = 0LL;
  v10 = 0LL;
  v11 = 0LL;
  v12 = 0LL;
  octet_string = 0LL;
  v14 = 0LL;
  switch ( v8 )
  {
    case 0:
      goto LABEL_16;
    case 1:
      v15.ptr = (char *)p7a->d;
      v10 = (const stack_st_X509_ALGOR *)*((_QWORD *)v15.ptr + 1);
      octet_string = PKCS7_get_octet_string(*((PKCS7 **)v15.ptr + 5));
      v9 = 0LL;
      v11 = 0LL;
      v12 = 0LL;
      goto LABEL_14;
    case 2:
      v20.ptr = (char *)p7a->d;
      v21 = *((_QWORD *)v20.ptr + 2);
      v9 = *(const EVP_CIPHER **)(v21 + 24);
      if ( v9 )
      {
        v11 = (stack_st_PKCS7_RECIP_INFO *)*((_QWORD *)v20.ptr + 1);
        v12 = *(X509_ALGOR **)(v21 + 8);
        v10 = 0LL;
        goto LABEL_13;
      }
      ERR_new();
      v43 = 272;
      goto LABEL_46;
    case 3:
      ptr = p7a->d.ptr;
      v23 = ptr[5];
      v9 = *(const EVP_CIPHER **)(v23 + 24);
      if ( !v9 )
      {
        ERR_new();
        v43 = 263;
LABEL_46:
        ERR_set_debug("crypto/pkcs7/pk7_doit.c", v43, "PKCS7_dataInit");
        v18 = 0LL;
        v19 = 116;
LABEL_47:
        ERR_set_error(33, v19, 0LL);
        goto LABEL_65;
      }
      v11 = (stack_st_PKCS7_RECIP_INFO *)ptr[6];
      v10 = (const stack_st_X509_ALGOR *)ptr[1];
      v12 = *(X509_ALGOR **)(v23 + 8);
LABEL_13:
      octet_string = 0LL;
LABEL_14:
      v14 = 0LL;
LABEL_16:
      evp_cipher = v9;
      keylen = v14;
      xalg = v12;
      rsk = v11;
      os = octet_string;
      bioa = bio;
      v25 = ossl_check_const_X509_ALGOR_sk_type(v10);
      if ( OPENSSL_sk_num(v25) > 0 )
      {
        v26 = 0;
        while ( 1 )
        {
          v27 = (X509_ALGOR *)OPENSSL_sk_value(v25, v26);
          if ( !pkcs7_bio_add_digest(&out, v27, v3) )
            break;
          if ( ++v26 >= OPENSSL_sk_num(v25) )
            goto LABEL_20;
        }
        v32 = 0LL;
        goto LABEL_42;
      }
LABEL_20:
      if ( keylen && !pkcs7_bio_add_digest(&out, keylen, v3) )
        goto LABEL_64;
      v28 = (PKCS7_0 *)p7a;
      if ( evp_cipher )
      {
        v29 = evp_cipher;
        v30 = BIO_f_cipher();
        v31 = BIO_new(v30);
        v32 = v31;
        if ( !v31 )
        {
          ERR_new();
          ERR_set_debug("crypto/pkcs7/pk7_doit.c", 301, "PKCS7_dataInit");
          v18 = 0LL;
          ERR_set_error(33, 524320, 0LL);
          goto err;
        }
        BIO_ctrl(v31, 129, 0LL, &parg);
        LODWORD(keylen) = EVP_CIPHER_get_key_length(evp_cipher);
        iv_length = EVP_CIPHER_get_iv_length(evp_cipher);
        type = EVP_CIPHER_get_type(evp_cipher);
        xalg->algorithm = OBJ_nid2obj(type);
        v35 = libctx;
        if ( iv_length > 0 && RAND_bytes_ex(libctx, iv, iv_length, 0) <= 0 )
          goto LABEL_42;
        ERR_set_mark();
        v36 = v29;
        v37 = EVP_CIPHER_get0_name(v29);
        v18 = EVP_CIPHER_fetch(v35, v37, propq);
        ERR_pop_to_mark();
        if ( v18 )
          v36 = v18;
        if ( EVP_CipherInit_ex(parg, v36, 0LL, 0LL, 0LL, 1) <= 0 )
          goto err;
        EVP_CIPHER_free(v18);
        if ( EVP_CIPHER_CTX_rand_key(parg, key) <= 0 )
          goto LABEL_42;
        v18 = 0LL;
        if ( EVP_CipherInit_ex(parg, 0LL, 0LL, key, iv, 1) <= 0 )
        {
err:
          EVP_CIPHER_free(v18);
          BIO_free_all(out);
          BIO_free_all(v32);
          return 0LL;
        }
        if ( iv_length > 0 )
        {
          if ( (parameter = xalg->parameter) == 0LL
            && (v39 = xalg, parameter = (ASN1_TYPE *)ASN1_TYPE_new(), (v39->parameter = parameter) == 0LL)
            || EVP_CIPHER_param_to_asn1((EVP_CIPHER_CTX *)parg, parameter) < 0 )
          {
LABEL_42:
            v18 = 0LL;
            goto err;
          }
        }
        v40 = ossl_check_const_PKCS7_RECIP_INFO_sk_type(rsk);
        if ( OPENSSL_sk_num(v40) > 0 )
        {
          v18 = 0LL;
          v41 = 0;
          do
          {
            v42 = (PKCS7_RECIP_INFO *)OPENSSL_sk_value(v40, v41);
            if ( pkcs7_encode_rinfo(v42, key, (int)keylen) <= 0 )
              goto err;
          }
          while ( ++v41 < OPENSSL_sk_num(v40) );
        }
        OPENSSL_cleanse(key, (int)keylen);
        if ( out )
          BIO_push(out, v32);
        else
          out = v32;
        v28 = (PKCS7_0 *)p7a;
      }
      v44 = bioa;
      if ( bioa )
        goto LABEL_51;
      if ( OBJ_obj2nid(v28->type) == 22 && PKCS7_ctrl(v28, 2, 0LL, 0LL) )
      {
        v45 = BIO_s_null();
        v46 = BIO_new(v45);
        goto LABEL_60;
      }
      if ( os && os->length > 0 )
      {
        v46 = BIO_new_mem_buf(os->data, os->length);
LABEL_60:
        v44 = v46;
        if ( !v46 )
          goto LABEL_64;
        goto LABEL_51;
      }
      v47 = BIO_s_mem();
      v48 = BIO_new(v47);
      if ( !v48 )
      {
LABEL_64:
        v18 = 0LL;
LABEL_65:
        v32 = 0LL;
        goto err;
      }
      v44 = v48;
      BIO_ctrl(v48, 130, 0LL, 0LL);
LABEL_51:
      v16 = out;
      if ( out )
      {
        BIO_push(out, v44);
      }
      else
      {
        out = v44;
        return v44;
      }
      return v16;
    case 4:
      v24.ptr = (char *)p7a->d;
      v14 = (X509_ALGOR *)*((_QWORD *)v24.ptr + 1);
      octet_string = PKCS7_get_octet_string(*((PKCS7 **)v24.ptr + 2));
      v9 = 0LL;
      v10 = 0LL;
      v11 = 0LL;
      v12 = 0LL;
      goto LABEL_16;
    default:
      ERR_new();
      ERR_set_debug("crypto/pkcs7/pk7_doit.c", 283, "PKCS7_dataInit");
      v18 = 0LL;
      v19 = 112;
      goto LABEL_47;
  }
}
