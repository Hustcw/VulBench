int __fastcall PKCS7_dataFinal(PKCS7 *p7, BIO *bio)
{
  PKCS7_0 *v2;
  EVP_MD_CTX_0 *v3;
  EVP_MD_CTX *v4;
  int v5;
  int v6;
  int v7;
  union {char *ptr;ASN1_OCTET_STRING *data;PKCS7_SIGNED *sign;PKCS7_ENVELOPE *enveloped;PKCS7_SIGN_ENVELOPE *signed_and_enveloped;PKCS7_DIGEST *digest;PKCS7_ENCRYPT *encrypted;ASN1_TYPE *other;} v8;
  const stack_st_PKCS7_SIGNER_INFO *v9;
  ASN1_OCTET_STRING *octet_string;
  int v11;
  ASN1_OCTET_STRING *v12;
  __int64 v13;
  union {char *ptr;ASN1_OCTET_STRING *data;PKCS7_SIGNED *sign;PKCS7_ENVELOPE *enveloped;PKCS7_SIGN_ENVELOPE *signed_and_enveloped;PKCS7_DIGEST *digest;PKCS7_ENCRYPT *encrypted;ASN1_TYPE *other;} v14;
  ASN1_OCTET_STRING *v15;
  int v16;
  ASN1_OCTET_STRING *v17;
  const OPENSSL_STACK *v18;
  int v19;
  PKCS7_SIGNER_INFO *v20;
  PKCS7_SIGNER_INFO *v21;
  int v22;
  const OPENSSL_STACK *v23;
  const PKCS7_CTX *v24;
  void *v25;
  void *v26;
  const char *v27;
  __int64 v28;
  ASN1_STRING *v29;
  BIO *type;
  BIO *v31;
  int v32;
  int v33;
  void *abuflen[9];
  EVP_PKEY *pkey;
  OSSL_LIB_CTX *libctx;
  PKCS7 *p7a;
  unsigned int md_len;
  EVP_MD_CTX *mdc;
  EVP_MD_CTX *ctx;
  ASN1_OCTET_STRING *os;
  BIO *btmp;

  v2 = (PKCS7_0 *)p7;
  v3 = EVP_MD_CTX_new();
  if ( !v3 )
  {
    ERR_new();
    ERR_set_debug("crypto/pkcs7/pk7_doit.c", 772, "PKCS7_dataFinal");
    v6 = 0;
    ERR_set_error(33, 786688, 0LL);
    return v6;
  }
  v4 = (EVP_MD_CTX *)v3;
  v5 = OBJ_obj2nid(p7->type);
  p7->state = 0;
  switch ( v5 )
  {
    case 21:
      btmp = bio;
      os = p7->d.data;
      goto LABEL_36;
    case 22:
      v8.ptr = (char *)p7->d;
      v9 = (const stack_st_PKCS7_SIGNER_INFO *)*((_QWORD *)v8.ptr + 4);
      octet_string = PKCS7_get_octet_string(*((PKCS7 **)v8.ptr + 5));
      v11 = OBJ_obj2nid(*(const ASN1_OBJECT **)(*((_QWORD *)p7->d.ptr + 5) + 24LL));
      btmp = bio;
      if ( v11 == 21 && p7->detached )
      {
        ASN1_OCTET_STRING_free(octet_string);
        *(_QWORD *)(*((_QWORD *)p7->d.ptr + 5) + 32LL) = 0LL;
        octet_string = 0LL;
      }
      goto LABEL_23;
    case 23:
      btmp = bio;
      os = *(ASN1_OCTET_STRING **)(*((_QWORD *)p7->d.ptr + 2) + 16LL);
      if ( os )
        goto LABEL_36;
      v12 = ASN1_OCTET_STRING_new();
      if ( v12 )
      {
        v13 = *((_QWORD *)p7->d.ptr + 2);
        os = v12;
        *(_QWORD *)(v13 + 16) = v12;
        goto LABEL_36;
      }
      ERR_new();
      v33 = 802;
      goto LABEL_46;
    case 24:
      v14.ptr = (char *)p7->d;
      v9 = (const stack_st_PKCS7_SIGNER_INFO *)*((_QWORD *)v14.ptr + 4);
      octet_string = *(ASN1_OCTET_STRING **)(*((_QWORD *)v14.ptr + 5) + 16LL);
      if ( octet_string )
      {
        btmp = bio;
      }
      else
      {
        v17 = ASN1_OCTET_STRING_new();
        if ( !v17 )
        {
          ERR_new();
          v33 = 790;
LABEL_46:
          ERR_set_debug("crypto/pkcs7/pk7_doit.c", v33, "PKCS7_dataFinal");
          v6 = 0;
          v7 = 786688;
          goto LABEL_47;
        }
        octet_string = v17;
        btmp = bio;
        *(_QWORD *)(*((_QWORD *)p7->d.ptr + 5) + 16LL) = v17;
      }
LABEL_23:
      os = octet_string;
      if ( !v9 )
        goto LABEL_36;
      v18 = ossl_check_const_PKCS7_SIGNER_INFO_sk_type(v9);
      if ( OPENSSL_sk_num(v18) <= 0 )
        goto LABEL_36;
      p7a = p7;
      v19 = 0;
      ctx = v4;
      break;
    case 25:
      v15 = PKCS7_get_octet_string(*((PKCS7 **)p7->d.ptr + 2));
      if ( OBJ_obj2nid(*(const ASN1_OBJECT **)(*((_QWORD *)p7->d.ptr + 2) + 24LL)) == 21 && p7->detached )
      {
        ASN1_OCTET_STRING_free(v15);
        *(_QWORD *)(*((_QWORD *)p7->d.ptr + 2) + 32LL) = 0LL;
        v15 = 0LL;
      }
      v16 = OBJ_obj2nid(**((const ASN1_OBJECT ***)p7->d.ptr + 1));
      if ( !PKCS7_find_digest(&mdc, bio, v16)
        || !EVP_DigestFinal_ex((EVP_MD_CTX_0 *)mdc, (unsigned __int8 *)abuflen, &md_len)
        || !ASN1_OCTET_STRING_set(*((ASN1_OCTET_STRING **)p7->d.ptr + 3), (const unsigned __int8 *)abuflen, md_len) )
      {
        goto LABEL_42;
      }
      os = v15;
      btmp = bio;
      goto LABEL_36;
    default:
      ERR_new();
      ERR_set_debug("crypto/pkcs7/pk7_doit.c", 830, "PKCS7_dataFinal");
      v6 = 0;
      v7 = 112;
      goto LABEL_47;
  }
  while ( 1 )
  {
    v20 = (PKCS7_SIGNER_INFO *)OPENSSL_sk_value(v18, v19);
    if ( v20->pkey )
      break;
LABEL_27:
    if ( ++v19 >= OPENSSL_sk_num(v18) )
    {
      v2 = (PKCS7_0 *)p7a;
LABEL_36:
      if ( OBJ_obj2nid(v2->type) == 22 )
      {
        v28 = PKCS7_ctrl(v2, 2, 0LL, 0LL);
        v6 = 1;
        if ( v28 )
          goto err;
      }
      v29 = os;
      if ( !os )
      {
LABEL_42:
        v6 = 0;
        goto err;
      }
      v6 = 1;
      if ( (os->flags & 0x10) != 0 )
        goto err;
      type = BIO_find_type(btmp, 1025);
      if ( type )
      {
        v31 = type;
        v32 = BIO_ctrl(type, 3, 0LL, abuflen);
        BIO_set_flags(v31, 512);
        BIO_ctrl(v31, 130, 0LL, 0LL);
        ASN1_STRING_set0(v29, abuflen[0], v32);
        goto err;
      }
      ERR_new();
      ERR_set_debug("crypto/pkcs7/pk7_doit.c", 906, "PKCS7_dataFinal");
      v6 = 0;
      v7 = 107;
LABEL_47:
      ERR_set_error(33, v7, 0LL);
      goto err;
    }
  }
  v21 = v20;
  v22 = OBJ_obj2nid(v20->digest_alg->algorithm);
  v6 = 0;
  if ( !PKCS7_find_digest(&mdc, btmp, v22) || !EVP_MD_CTX_copy_ex((EVP_MD_CTX_0 *)v4, (const EVP_MD_CTX_0 *)mdc) )
    goto err;
  v23 = ossl_check_const_X509_ATTRIBUTE_sk_type(v21->auth_attr);
  if ( OPENSSL_sk_num(v23) > 0 )
  {
    if ( !do_pkcs7_signed_attrib(v21, v4) )
      goto err;
    goto LABEL_27;
  }
  LODWORD(abuflen[0]) = EVP_PKEY_get_size(v21->pkey);
  v24 = (const PKCS7_CTX *)LODWORD(abuflen[0]);
  v25 = CRYPTO_malloc(LODWORD(abuflen[0]), "crypto/pkcs7/pk7_doit.c", 868);
  if ( !v25 )
    goto LABEL_51;
  v26 = v25;
  pkey = v21->pkey;
  libctx = ossl_pkcs7_ctx_get0_libctx(v24);
  v27 = ossl_pkcs7_ctx_get0_propq(v24);
  if ( EVP_SignFinal_ex(ctx, (unsigned __int8 *)v26, (unsigned int *)abuflen, pkey, libctx, v27) )
  {
    ASN1_STRING_set0(v21->enc_digest, v26, (int)abuflen[0]);
    v4 = ctx;
    goto LABEL_27;
  }
  CRYPTO_free(v26, "crypto/pkcs7/pk7_doit.c", 875);
  ERR_new();
  ERR_set_debug("crypto/pkcs7/pk7_doit.c", 876, "PKCS7_dataFinal");
  ERR_set_error(33, 524294, 0LL);
LABEL_51:
  v4 = ctx;
err:
  EVP_MD_CTX_free((EVP_MD_CTX_0 *)v4);
  return v6;
}
