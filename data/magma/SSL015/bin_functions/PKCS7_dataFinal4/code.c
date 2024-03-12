int __fastcall PKCS7_dataFinal(PKCS7 *p7, BIO *bio)
{
  const PKCS7_CTX *v3;
  const PKCS7_CTX *v4;
  EVP_MD_CTX *v5;
  EVP_MD_CTX *v6;
  int v7;
  int v8;
  int v9;
  int v10;
  EVP_MD_CTX *v11;
  union {char *ptr;ASN1_OCTET_STRING *data;PKCS7_SIGNED *sign;PKCS7_ENVELOPE *enveloped;PKCS7_SIGN_ENVELOPE *signed_and_enveloped;PKCS7_DIGEST *digest;PKCS7_ENCRYPT *encrypted;ASN1_TYPE *other;} v12;
  const stack_st_PKCS7_SIGNER_INFO *v13;
  int v14;
  ASN1_OCTET_STRING *v15;
  __int64 v16;
  union {char *ptr;ASN1_OCTET_STRING *data;PKCS7_SIGNED *sign;PKCS7_ENVELOPE *enveloped;PKCS7_SIGN_ENVELOPE *signed_and_enveloped;PKCS7_DIGEST *digest;PKCS7_ENCRYPT *encrypted;ASN1_TYPE *other;} v17;
  int v18;
  EVP_MD_CTX *v19;
  OPENSSL_STACK *v20;
  PKCS7_SIGNER_INFO *v21;
  PKCS7_SIGNER_INFO *v22;
  int v23;
  const OPENSSL_STACK *v24;
  unsigned __int8 *v25;
  const PKCS7_CTX *v26;
  const PKCS7_CTX *v27;
  unsigned __int8 *v28;
  const char *v29;
  ASN1_OCTET_STRING *octet_string;
  int v31;
  ASN1_OCTET_STRING *v32;
  __int64 v33;
  ASN1_OCTET_STRING *v34;
  BIO *type;
  BIO *v36;
  int v37;
  int v38;
  unsigned __int8 md_data[64];
  unsigned __int8 *abuf;
  EVP_PKEY *pkey;
  OSSL_LIB_CTX *libctx;
  const PKCS7_CTX *p7_ctx;
  OPENSSL_STACK *st;
  unsigned int md_len;
  EVP_MD_CTX *mdc;
  EVP_MD_CTX *ctx;
  BIO *btmp;
  ASN1_OCTET_STRING *os;

  if ( !p7 )
  {
    ERR_new();
    ERR_set_debug("crypto/pkcs7/pk7_doit.c", 754, "PKCS7_dataFinal");
    v8 = 0;
    v9 = 143;
LABEL_9:
    ERR_set_error(33, v9, 0LL);
    return v8;
  }
  v3 = ossl_pkcs7_get0_ctx((const PKCS7_0 *)p7);
  if ( !p7->d.ptr )
  {
    ERR_new();
    ERR_set_debug("crypto/pkcs7/pk7_doit.c", 761, "PKCS7_dataFinal");
    v8 = 0;
    v9 = 122;
    goto LABEL_9;
  }
  v4 = v3;
  v5 = EVP_MD_CTX_new();
  if ( !v5 )
  {
    ERR_new();
    ERR_set_debug("crypto/pkcs7/pk7_doit.c", 772, "PKCS7_dataFinal");
    v8 = 0;
    v9 = 786688;
    goto LABEL_9;
  }
  v6 = v5;
  v7 = OBJ_obj2nid(p7->type);
  p7->state = 0;
  switch ( v7 )
  {
    case 21:
      btmp = bio;
      os = p7->d.data;
      goto LABEL_43;
    case 22:
      v11 = v6;
      v12.ptr = (char *)p7->d;
      v13 = (const stack_st_PKCS7_SIGNER_INFO *)*((_QWORD *)v12.ptr + 4);
      os = PKCS7_get_octet_string(*((PKCS7 **)v12.ptr + 5));
      v14 = OBJ_obj2nid(*(const ASN1_OBJECT **)(*((_QWORD *)p7->d.ptr + 5) + 24LL));
      btmp = bio;
      if ( v14 != 21 || !p7->detached )
        goto LABEL_21;
      ASN1_OCTET_STRING_free(os);
      *(_QWORD *)(*((_QWORD *)p7->d.ptr + 5) + 32LL) = 0LL;
      os = 0LL;
      if ( !v13 )
        goto LABEL_42;
      goto LABEL_22;
    case 23:
      btmp = bio;
      os = *(ASN1_OCTET_STRING **)(*((_QWORD *)p7->d.ptr + 2) + 16LL);
      if ( os )
        goto LABEL_43;
      v15 = ASN1_OCTET_STRING_new();
      if ( v15 )
      {
        v16 = *((_QWORD *)p7->d.ptr + 2);
        os = v15;
        *(_QWORD *)(v16 + 16) = v15;
        goto LABEL_43;
      }
      ERR_new();
      ERR_set_debug("crypto/pkcs7/pk7_doit.c", 802, "PKCS7_dataFinal");
      v8 = 0;
      v10 = 786688;
LABEL_11:
      ERR_set_error(33, v10, 0LL);
      goto err;
    case 24:
      v11 = v6;
      v17.ptr = (char *)p7->d;
      v13 = (const stack_st_PKCS7_SIGNER_INFO *)*((_QWORD *)v17.ptr + 4);
      os = *(ASN1_OCTET_STRING **)(*((_QWORD *)v17.ptr + 5) + 16LL);
      if ( os )
      {
        btmp = bio;
LABEL_21:
        if ( !v13 )
          goto LABEL_42;
      }
      else
      {
        v32 = ASN1_OCTET_STRING_new();
        if ( !v32 )
        {
          ERR_new();
          ERR_set_debug("crypto/pkcs7/pk7_doit.c", 790, "PKCS7_dataFinal");
          v8 = 0;
          v38 = 786688;
          goto LABEL_54;
        }
        btmp = bio;
        v33 = *((_QWORD *)p7->d.ptr + 5);
        os = v32;
        *(_QWORD *)(v33 + 16) = v32;
        if ( !v13 )
          goto LABEL_42;
      }
LABEL_22:
      st = (OPENSSL_STACK *)ossl_check_const_PKCS7_SIGNER_INFO_sk_type(v13);
      if ( OPENSSL_sk_num(st) <= 0 )
      {
LABEL_42:
        v6 = v11;
        goto LABEL_43;
      }
      p7_ctx = v4;
      v18 = 0;
      v19 = v11;
      v20 = st;
      ctx = v11;
      while ( 1 )
      {
        v21 = (PKCS7_SIGNER_INFO *)OPENSSL_sk_value(v20, v18);
        v6 = v19;
        if ( v21->pkey )
          break;
LABEL_25:
        v19 = v6;
        ++v18;
        v20 = st;
        if ( v18 >= OPENSSL_sk_num(st) )
        {
          v6 = v19;
LABEL_43:
          if ( OBJ_obj2nid(p7->type) == 22 )
          {
            v8 = 1;
            if ( PKCS7_ctrl((PKCS7_0 *)p7, 2, 0LL, 0LL) )
              goto err;
          }
          v34 = os;
          if ( !os )
          {
LABEL_49:
            v8 = 0;
            goto err;
          }
          v8 = 1;
          if ( (os->flags & 0x10) != 0 )
            goto err;
          v11 = v6;
          type = BIO_find_type(btmp, 1025);
          if ( type )
          {
            v36 = type;
            v37 = BIO_ctrl(type, 3, 0LL, md_data);
            BIO_set_flags(v36, 512);
            BIO_ctrl(v36, 130, 0LL, 0LL);
            v6 = v11;
            ASN1_STRING_set0(v34, *(void **)md_data, v37);
            goto err;
          }
          ERR_new();
          ERR_set_debug("crypto/pkcs7/pk7_doit.c", 906, "PKCS7_dataFinal");
          v8 = 0;
          v38 = 107;
LABEL_54:
          ERR_set_error(33, v38, 0LL);
          v6 = v11;
          goto err;
        }
      }
      v22 = v21;
      v23 = OBJ_obj2nid(v21->digest_alg->algorithm);
      v8 = 0;
      if ( !PKCS7_find_digest(&mdc, btmp, v23) || !EVP_MD_CTX_copy_ex(v6, mdc) )
        goto err;
      v24 = ossl_check_const_X509_ATTRIBUTE_sk_type(v22->auth_attr);
      if ( OPENSSL_sk_num(v24) > 0 )
      {
        if ( !do_pkcs7_signed_attrib(v22, v6) )
          goto err;
        goto LABEL_25;
      }
      *(_DWORD *)md_data = EVP_PKEY_get_size(v22->pkey);
      v25 = (unsigned __int8 *)CRYPTO_malloc(*(unsigned int *)md_data, "crypto/pkcs7/pk7_doit.c", 868);
      if ( !v25 )
        goto LABEL_56;
      pkey = v22->pkey;
      abuf = v25;
      v26 = p7_ctx;
      libctx = ossl_pkcs7_ctx_get0_libctx(p7_ctx);
      v27 = v26;
      v28 = abuf;
      v29 = ossl_pkcs7_ctx_get0_propq(v27);
      if ( EVP_SignFinal_ex(ctx, v28, (unsigned int *)md_data, pkey, libctx, v29) )
      {
        ASN1_STRING_set0(v22->enc_digest, v28, *(int *)md_data);
        v6 = ctx;
        goto LABEL_25;
      }
      CRYPTO_free(v28, "crypto/pkcs7/pk7_doit.c", 875);
      ERR_new();
      ERR_set_debug("crypto/pkcs7/pk7_doit.c", 876, "PKCS7_dataFinal");
      ERR_set_error(33, 524294, 0LL);
LABEL_56:
      v6 = ctx;
err:
      EVP_MD_CTX_free(v6);
      return v8;
    case 25:
      octet_string = PKCS7_get_octet_string(*((PKCS7 **)p7->d.ptr + 2));
      if ( OBJ_obj2nid(*(const ASN1_OBJECT **)(*((_QWORD *)p7->d.ptr + 2) + 24LL)) == 21 && p7->detached )
      {
        ASN1_OCTET_STRING_free(octet_string);
        *(_QWORD *)(*((_QWORD *)p7->d.ptr + 2) + 32LL) = 0LL;
        octet_string = 0LL;
      }
      v31 = OBJ_obj2nid(**((const ASN1_OBJECT ***)p7->d.ptr + 1));
      if ( !PKCS7_find_digest(&mdc, bio, v31)
        || !EVP_DigestFinal_ex(mdc, md_data, &md_len)
        || !ASN1_OCTET_STRING_set(*((ASN1_OCTET_STRING **)p7->d.ptr + 3), md_data, md_len) )
      {
        goto LABEL_49;
      }
      os = octet_string;
      btmp = bio;
      goto LABEL_43;
    default:
      ERR_new();
      ERR_set_debug("crypto/pkcs7/pk7_doit.c", 830, "PKCS7_dataFinal");
      v8 = 0;
      v10 = 112;
      goto LABEL_11;
  }
}
