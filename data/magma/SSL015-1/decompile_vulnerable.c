BIO *__fastcall PKCS7_dataInit(PKCS7 *p7, BIO *bio)
{
  int v2;
  int v3;
  X509_ALGOR *v4;
  EVP_CIPHER *v5;
  const stack_st_X509_ALGOR *v6;
  stack_st_PKCS7_RECIP_INFO *v7;
  BIO *v8;
  ASN1_OCTET_STRING *octet_string;
  union {char *ptr;ASN1_OCTET_STRING *data;PKCS7_SIGNED *sign;PKCS7_ENVELOPE *enveloped;PKCS7_SIGN_ENVELOPE *signed_and_enveloped;PKCS7_DIGEST *digest;PKCS7_ENCRYPT *encrypted;ASN1_TYPE *other;} v10;
  BIO *v11;
  int v12;
  union {char *ptr;ASN1_OCTET_STRING *data;PKCS7_SIGNED *sign;PKCS7_ENVELOPE *enveloped;PKCS7_SIGN_ENVELOPE *signed_and_enveloped;PKCS7_DIGEST *digest;PKCS7_ENCRYPT *encrypted;ASN1_TYPE *other;} v13;
  __int64 v14;
  _QWORD *ptr;
  __int64 v16;
  union {char *ptr;ASN1_OCTET_STRING *data;PKCS7_SIGNED *sign;PKCS7_ENVELOPE *enveloped;PKCS7_SIGN_ENVELOPE *signed_and_enveloped;PKCS7_DIGEST *digest;PKCS7_ENCRYPT *encrypted;ASN1_TYPE *other;} v17;
  const OPENSSL_STACK *v18;
  const PKCS7_CTX *v19;
  int v20;
  X509_ALGOR *v21;
  const PKCS7_CTX *v22;
  PKCS7_0 *v23;
  const BIO_METHOD *v24;
  BIO *v25;
  int iv_length;
  unsigned int type;
  OSSL_LIB_CTX *v28;
  EVP_CIPHER *v29;
  const char *v30;
  const char *v31;
  ASN1_TYPE_0 *method;
  BIO *v33;
  const OPENSSL_STACK *v34;
  int v35;
  PKCS7_RECIP_INFO *v36;
  int v37;
  BIO *v38;
  BIO *v39;
  const BIO_METHOD *v40;
  BIO *v41;
  const BIO_METHOD *v42;
  BIO *v43;
  unsigned __int8 key[64];
  unsigned __int8 iv[16];
  PKCS7 *p7a;
  BIO *bioa;
  ASN1_OCTET_STRING *os;
  stack_st_PKCS7_RECIP_INFO *rsk;
  void *parg;
  int keylen;
  BIO *btmp;
  BIO *out[6];

  out[0] = 0LL;
  v2 = OBJ_obj2nid(p7->type);
  p7->state = 0;
  v3 = v2 - 21;
  bioa = bio;
  v4 = 0LL;
  v5 = 0LL;
  v6 = 0LL;
  v7 = 0LL;
  v8 = 0LL;
  octet_string = 0LL;
  switch ( v3 )
  {
    case 0:
      goto LABEL_11;
    case 1:
      v10.ptr = (char *)p7->d;
      v6 = (const stack_st_X509_ALGOR *)*((_QWORD *)v10.ptr + 1);
      octet_string = PKCS7_get_octet_string(*((PKCS7 **)v10.ptr + 5));
      v4 = 0LL;
      v5 = 0LL;
      goto LABEL_10;
    case 2:
      v13.ptr = (char *)p7->d;
      v14 = *((_QWORD *)v13.ptr + 2);
      v5 = *(EVP_CIPHER **)(v14 + 24);
      if ( v5 )
      {
        v7 = (stack_st_PKCS7_RECIP_INFO *)*((_QWORD *)v13.ptr + 1);
        v8 = *(BIO **)(v14 + 8);
        v4 = 0LL;
        v6 = 0LL;
        goto LABEL_8;
      }
      ERR_new();
      v37 = 272;
      goto LABEL_40;
    case 3:
      ptr = p7->d.ptr;
      v16 = ptr[5];
      v5 = *(EVP_CIPHER **)(v16 + 24);
      if ( !v5 )
      {
        ERR_new();
        v37 = 263;
LABEL_40:
        ERR_set_debug("crypto/pkcs7/pk7_doit.c", v37, "PKCS7_dataInit");
        v11 = 0LL;
        v12 = 116;
LABEL_41:
        ERR_set_error(33, v12, 0LL);
        goto LABEL_59;
      }
      v7 = (stack_st_PKCS7_RECIP_INFO *)ptr[6];
      v6 = (const stack_st_X509_ALGOR *)ptr[1];
      v8 = *(BIO **)(v16 + 8);
      v4 = 0LL;
LABEL_8:
      octet_string = 0LL;
LABEL_11:
      btmp = v8;
      rsk = v7;
      os = octet_string;
      p7a = p7;
      v18 = ossl_check_const_X509_ALGOR_sk_type(v6);
      if ( OPENSSL_sk_num(v18) > 0 )
      {
        v20 = 0;
        while ( 1 )
        {
          v21 = (X509_ALGOR *)OPENSSL_sk_value(v18, v20);
          if ( !pkcs7_bio_add_digest(out, v21, v22) )
            break;
          if ( ++v20 >= OPENSSL_sk_num(v18) )
            goto LABEL_15;
        }
        v29 = 0LL;
        v11 = 0LL;
err:
        EVP_CIPHER_free(v29);
        BIO_free_all(out[0]);
        BIO_free_all(v11);
        return 0LL;
      }
LABEL_15:
      if ( v4 && !pkcs7_bio_add_digest(out, v4, v19) )
        goto LABEL_58;
      v23 = (PKCS7_0 *)p7a;
      if ( !v5 )
        goto LABEL_44;
      v24 = BIO_f_cipher();
      v25 = BIO_new(v24);
      v11 = v25;
      if ( !v25 )
      {
        ERR_new();
        ERR_set_debug("crypto/pkcs7/pk7_doit.c", 301, "PKCS7_dataInit");
        v29 = 0LL;
        ERR_set_error(33, 524320, 0LL);
        goto err;
      }
      BIO_ctrl(v25, 129, 0LL, &parg);
      keylen = EVP_CIPHER_get_key_length(v5);
      iv_length = EVP_CIPHER_get_iv_length(v5);
      type = EVP_CIPHER_get_type(v5);
      v28 = (OSSL_LIB_CTX *)type;
      btmp->libctx = (OSSL_LIB_CTX *)OBJ_nid2obj(type);
      if ( iv_length > 0 )
      {
        v29 = 0LL;
        if ( RAND_bytes_ex(v28, iv, iv_length, 0) <= 0 )
          goto err;
      }
      ERR_set_mark();
      v30 = EVP_CIPHER_get0_name(v5);
      v29 = EVP_CIPHER_fetch((OSSL_LIB_CTX *)v5, v30, v31);
      ERR_pop_to_mark();
      if ( v29 )
        v5 = v29;
      if ( EVP_CipherInit_ex((EVP_CIPHER_CTX_0 *)parg, v5, 0LL, 0LL, 0LL, 1) <= 0 )
        goto err;
      EVP_CIPHER_free(v29);
      if ( EVP_CIPHER_CTX_rand_key((EVP_CIPHER_CTX_0 *)parg, key) <= 0 )
        goto LABEL_59;
      v29 = 0LL;
      if ( EVP_CipherInit_ex((EVP_CIPHER_CTX_0 *)parg, 0LL, 0LL, key, iv, 1) <= 0 )
        goto err;
      if ( iv_length > 0 )
      {
        method = (ASN1_TYPE_0 *)btmp->method;
        if ( !method )
        {
          v33 = btmp;
          method = (ASN1_TYPE_0 *)ASN1_TYPE_new();
          v33->method = (const BIO_METHOD *)method;
          if ( !method )
            goto LABEL_59;
        }
        if ( EVP_CIPHER_param_to_asn1((EVP_CIPHER_CTX *)parg, method) < 0 )
          goto LABEL_59;
      }
      btmp = v11;
      v34 = ossl_check_const_PKCS7_RECIP_INFO_sk_type(rsk);
      if ( OPENSSL_sk_num(v34) > 0 )
      {
        v29 = 0LL;
        v35 = 0;
        while ( 1 )
        {
          v36 = (PKCS7_RECIP_INFO *)OPENSSL_sk_value(v34, v35);
          if ( pkcs7_encode_rinfo(v36, key, keylen) <= 0 )
            break;
          if ( ++v35 >= OPENSSL_sk_num(v34) )
            goto LABEL_34;
        }
        v11 = btmp;
        goto err;
      }
LABEL_34:
      OPENSSL_cleanse(key, keylen);
      if ( out[0] )
        BIO_push(out[0], btmp);
      else
        out[0] = btmp;
LABEL_44:
      v38 = bioa;
      if ( bioa )
        goto LABEL_45;
      if ( OBJ_obj2nid(v23->type) == 22 && PKCS7_ctrl(v23, 2, 0LL, 0LL) )
      {
        v40 = BIO_s_null();
        v41 = BIO_new(v40);
        goto LABEL_54;
      }
      if ( os && os->length > 0 )
      {
        v41 = BIO_new_mem_buf(os->data, os->length);
LABEL_54:
        v38 = v41;
        if ( !v41 )
          goto LABEL_58;
        goto LABEL_45;
      }
      v42 = BIO_s_mem();
      v43 = BIO_new(v42);
      if ( !v43 )
      {
LABEL_58:
        v11 = 0LL;
LABEL_59:
        v29 = 0LL;
        goto err;
      }
      v38 = v43;
      BIO_ctrl(v43, 130, 0LL, 0LL);
LABEL_45:
      v39 = out[0];
      if ( out[0] )
      {
        BIO_push(out[0], v38);
      }
      else
      {
        out[0] = v38;
        return v38;
      }
      return v39;
    case 4:
      v17.ptr = (char *)p7->d;
      v4 = (X509_ALGOR *)*((_QWORD *)v17.ptr + 1);
      octet_string = PKCS7_get_octet_string(*((PKCS7 **)v17.ptr + 2));
      v5 = 0LL;
      v6 = 0LL;
LABEL_10:
      v7 = 0LL;
      v8 = 0LL;
      goto LABEL_11;
    default:
      ERR_new();
      ERR_set_debug("crypto/pkcs7/pk7_doit.c", 283, "PKCS7_dataInit");
      v11 = 0LL;
      v12 = 112;
      goto LABEL_41;
  }
}
