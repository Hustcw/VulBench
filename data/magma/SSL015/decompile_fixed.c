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


BIO *__fastcall PKCS7_dataDecode(PKCS7 *p7, EVP_PKEY *pkey, BIO *in_bio, X509 *pcert)
{
  const PKCS7_CTX *v5;
  OSSL_LIB_CTX *v6;
  int v7;
  ASN1_OCTET_STRING *octet_string;
  __int64 v9;
  int v10;
  BIO *v11;
  int v12;
  union {char *ptr;ASN1_OCTET_STRING *data;PKCS7_SIGNED *sign;PKCS7_ENVELOPE *enveloped;PKCS7_SIGN_ENVELOPE *signed_and_enveloped;PKCS7_DIGEST *digest;PKCS7_ENCRYPT *encrypted;ASN1_TYPE *other;} v13;
  const stack_st_X509_ALGOR *v14;
  __int64 v15;
  EVP_CIPHER *v16;
  BIO *v17;
  union {char *ptr;ASN1_OCTET_STRING *data;PKCS7_SIGNED *sign;PKCS7_ENVELOPE *enveloped;PKCS7_SIGN_ENVELOPE *signed_and_enveloped;PKCS7_DIGEST *digest;PKCS7_ENCRYPT *encrypted;ASN1_TYPE *other;} v18;
  __int64 v19;
  const OPENSSL_STACK *v20;
  int v21;
  const OPENSSL_STACK *v22;
  const ASN1_OBJECT **v23;
  const BIO_METHOD *v24;
  BIO *v25;
  EVP_MD *v26;
  EVP_MD *digestbyname;
  const BIO_METHOD *v28;
  BIO *v29;
  const OPENSSL_STACK *v30;
  int v31;
  PKCS7_RECIP_INFO *v32;
  BIO *v33;
  int v34;
  int v35;
  unsigned __int8 *v36;
  __int64 v37;
  int v39;
  const OPENSSL_STACK *v40;
  int v41;
  PKCS7_RECIP_INFO *v42;
  int key_length;
  int v44;
  int v45;
  size_t v46;
  unsigned __int8 *v47;
  unsigned __int8 *v48;
  int v49;
  int v50;
  const BIO_METHOD *v51;
  BIO *v52;
  char name[50];
  ASN1_OCTET_STRING *data_body;
  OSSL_LIB_CTX *v55;
  X509_ALGOR *enc_alg;
  BIO *in_bioa;
  const PKCS7_CTX *p7_ctx;
  EVP_PKEY *pkeya;
  stack_st_PKCS7_RECIP_INFO *rsk;
  __int64 tkeylen;
  unsigned __int8 *ek;
  const EVP_CIPHER *cipher;
  EVP_CIPHER_CTX *parg;
  unsigned __int8 *tkey;
  EVP_CIPHER *evp_cipher;
  int eklen;
  const char *propq;
  BIO *out;

  parg = 0LL;
  ek = 0LL;
  eklen = 0;
  if ( p7 )
  {
    tkey = (unsigned __int8 *)pcert;
    v5 = ossl_pkcs7_get0_ctx((const PKCS7_0 *)p7);
    v6 = ossl_pkcs7_ctx_get0_libctx(v5);
    propq = ossl_pkcs7_ctx_get0_propq(v5);
    if ( p7->d.ptr )
    {
      v7 = OBJ_obj2nid(p7->type);
      p7->state = 0;
      switch ( v7 )
      {
        case 24:
          p7_ctx = v5;
          pkeya = pkey;
          v13.ptr = (char *)p7->d;
          rsk = (stack_st_PKCS7_RECIP_INFO *)*((_QWORD *)v13.ptr + 6);
          v14 = (const stack_st_X509_ALGOR *)*((_QWORD *)v13.ptr + 1);
          v15 = *((_QWORD *)v13.ptr + 5);
          octet_string = *(ASN1_OCTET_STRING **)(v15 + 16);
          enc_alg = *(X509_ALGOR **)(v15 + 8);
          OBJ_obj2txt(name, 50, enc_alg->algorithm, 0);
          ERR_set_mark();
          v16 = EVP_CIPHER_fetch(v6, name, propq);
          cipher = v16;
          if ( v16 || (cipher = EVP_get_cipherbyname(name)) != 0LL )
          {
            ERR_pop_to_mark();
            if ( in_bio )
              goto LABEL_25;
            goto LABEL_16;
          }
          ERR_clear_last_mark();
          ERR_new();
          v35 = 475;
          break;
        case 23:
          p7_ctx = v5;
          v18.ptr = (char *)p7->d;
          rsk = (stack_st_PKCS7_RECIP_INFO *)*((_QWORD *)v18.ptr + 1);
          v19 = *((_QWORD *)v18.ptr + 2);
          octet_string = *(ASN1_OCTET_STRING **)(v19 + 16);
          enc_alg = *(X509_ALGOR **)(v19 + 8);
          OBJ_obj2txt(name, 50, enc_alg->algorithm, 0);
          ERR_set_mark();
          v16 = EVP_CIPHER_fetch(v6, name, propq);
          cipher = v16;
          if ( v16 || (cipher = EVP_get_cipherbyname(name)) != 0LL )
          {
            pkeya = pkey;
            ERR_pop_to_mark();
            v14 = 0LL;
            if ( in_bio )
              goto LABEL_25;
            goto LABEL_16;
          }
          ERR_clear_last_mark();
          ERR_new();
          v35 = 496;
          break;
        case 22:
          p7_ctx = v5;
          octet_string = PKCS7_get_octet_string(*((PKCS7 **)p7->d.ptr + 5));
          if ( OBJ_obj2nid(p7->type) == 22 )
          {
            v9 = PKCS7_ctrl((PKCS7_0 *)p7, 2, 0LL, 0LL);
            if ( !octet_string && !v9 )
              goto LABEL_9;
          }
          else if ( !octet_string )
          {
LABEL_9:
            ERR_new();
            ERR_set_debug("crypto/pkcs7/pk7_doit.c", 452, "PKCS7_dataDecode");
            propq = 0LL;
            v10 = 155;
LABEL_53:
            ERR_set_error(33, v10, 0LL);
            v17 = 0LL;
            v16 = 0LL;
            goto LABEL_54;
          }
          pkeya = pkey;
          v14 = (const stack_st_X509_ALGOR *)*((_QWORD *)p7->d.ptr + 1);
          v16 = 0LL;
          cipher = 0LL;
          enc_alg = 0LL;
          rsk = 0LL;
          if ( in_bio )
          {
LABEL_25:
            tkeylen = 0LL;
            evp_cipher = v16;
            in_bioa = in_bio;
            data_body = octet_string;
            if ( v14 )
            {
              v20 = ossl_check_const_X509_ALGOR_sk_type(v14);
              v21 = 0;
              if ( OPENSSL_sk_num(v20) > 0 )
              {
                out = 0LL;
                v55 = v6;
                while ( 1 )
                {
                  v22 = v20;
                  v23 = (const ASN1_OBJECT **)OPENSSL_sk_value(v20, v21);
                  v24 = BIO_f_md();
                  v25 = BIO_new(v24);
                  if ( !v25 )
                  {
                    ERR_new();
                    v34 = 522;
                    goto LABEL_48;
                  }
                  v17 = v25;
                  OBJ_obj2txt(name, 50, *v23, 0);
                  ERR_set_mark();
                  v26 = EVP_MD_fetch(v6, name, propq);
                  digestbyname = v26;
                  if ( !v26 )
                  {
                    digestbyname = (EVP_MD *)EVP_get_digestbyname(name);
                    if ( !digestbyname )
                      break;
                  }
                  ERR_pop_to_mark();
                  BIO_ctrl(v17, 111, 0LL, digestbyname);
                  EVP_MD_free(v26);
                  if ( out )
                    BIO_push(out, v17);
                  else
                    out = v17;
                  v6 = v55;
                  ++v21;
                  v20 = v22;
                  if ( v21 >= OPENSSL_sk_num(v22) )
                    goto LABEL_36;
                }
                ERR_clear_last_mark();
                ERR_new();
                ERR_set_debug("crypto/pkcs7/pk7_doit.c", 537, "PKCS7_dataDecode");
                propq = 0LL;
                v39 = 109;
                goto LABEL_63;
              }
            }
            out = 0LL;
LABEL_36:
            if ( cipher )
            {
              v28 = BIO_f_cipher();
              v29 = BIO_new(v28);
              if ( v29 )
              {
                propq = (const char *)v29;
                if ( !tkey )
                  goto LABEL_66;
                v30 = ossl_check_const_PKCS7_RECIP_INFO_sk_type(rsk);
                if ( OPENSSL_sk_num(v30) <= 0 )
                  goto LABEL_62;
                v31 = 0;
                while ( 1 )
                {
                  v32 = (PKCS7_RECIP_INFO *)OPENSSL_sk_value(v30, v31);
                  if ( !pkcs7_cmp_ri(v32, (X509 *)tkey) )
                    break;
                  if ( ++v31 >= OPENSSL_sk_num(v30) )
                    goto LABEL_62;
                }
                if ( !v32 )
                {
LABEL_62:
                  ERR_new();
                  ERR_set_debug("crypto/pkcs7/pk7_doit.c", 577, "PKCS7_dataDecode");
                  v17 = 0LL;
                  v39 = 115;
LABEL_63:
                  ERR_set_error(33, v39, 0LL);
                  goto LABEL_64;
                }
                if ( tkey )
                {
                  v32->ctx = p7_ctx;
                  v36 = 0LL;
                  if ( pkcs7_decrypt_rinfo(&ek, &eklen, v32, pkeya, 0LL) < 0 )
                  {
                    v17 = 0LL;
                    goto LABEL_65;
                  }
                  ERR_clear_error();
                }
                else
                {
LABEL_66:
                  v40 = ossl_check_const_PKCS7_RECIP_INFO_sk_type(rsk);
                  if ( OPENSSL_sk_num(v40) > 0 )
                  {
                    v41 = 0;
                    while ( 1 )
                    {
                      v42 = (PKCS7_RECIP_INFO *)OPENSSL_sk_value(v40, v41);
                      v42->ctx = p7_ctx;
                      key_length = EVP_CIPHER_get_key_length(cipher);
                      if ( pkcs7_decrypt_rinfo(&ek, &eklen, v42, pkeya, key_length) < 0 )
                        break;
                      ERR_clear_error();
                      if ( ++v41 >= OPENSSL_sk_num(v40) )
                        goto LABEL_70;
                    }
                    v17 = 0LL;
                    v36 = 0LL;
                    v16 = evp_cipher;
                    v11 = out;
                    LODWORD(v37) = 0;
                    goto err;
                  }
                }
LABEL_70:
                parg = 0LL;
                BIO_ctrl((BIO *)propq, 129, 0LL, &parg);
                if ( EVP_CipherInit_ex((EVP_CIPHER_CTX_0 *)parg, cipher, 0LL, 0LL, 0LL, 0) > 0 )
                {
                  v44 = EVP_CIPHER_asn1_to_param(parg, enc_alg->parameter);
                  v16 = evp_cipher;
                  if ( v44 < 0 || (v45 = EVP_CIPHER_CTX_get_key_length(parg), v45 <= 0) )
                  {
                    v17 = 0LL;
                    v36 = 0LL;
                    LODWORD(v37) = 0;
                    v11 = out;
                    goto err;
                  }
                  v37 = (unsigned int)v45;
                  v46 = v45;
                  v47 = (unsigned __int8 *)CRYPTO_malloc(v45, "crypto/pkcs7/pk7_doit.c", 615);
                  if ( !v47 )
                  {
                    v17 = 0LL;
                    v36 = 0LL;
                    v11 = out;
                    goto err;
                  }
                  tkey = v47;
                  if ( EVP_CIPHER_CTX_rand_key((EVP_CIPHER_CTX_0 *)parg, v47) <= 0 )
                  {
                    v17 = 0LL;
                    v36 = tkey;
                    v11 = out;
                    goto err;
                  }
                  v48 = ek;
                  if ( ek )
                  {
                    v49 = eklen;
                  }
                  else
                  {
                    v48 = tkey;
                    ek = tkey;
                    eklen = v37;
                    v49 = v37;
                    tkey = 0LL;
                  }
                  v50 = EVP_CIPHER_CTX_get_key_length(parg);
                  tkeylen = v37;
                  if ( v49 != v50 && !EVP_CIPHER_CTX_set_key_length((EVP_CIPHER_CTX_0 *)parg, v49) )
                  {
                    CRYPTO_clear_free(v48, v49, "crypto/pkcs7/pk7_doit.c", 634);
                    v48 = tkey;
                    ek = tkey;
                    eklen = v37;
                    v49 = v37;
                    tkey = 0LL;
                  }
                  ERR_clear_error();
                  v17 = 0LL;
                  if ( EVP_CipherInit_ex((EVP_CIPHER_CTX_0 *)parg, 0LL, 0LL, v48, 0LL, 0) <= 0 )
                  {
                    v16 = evp_cipher;
                    v11 = out;
                    LODWORD(v37) = tkeylen;
                    v36 = tkey;
                    goto err;
                  }
                  CRYPTO_clear_free(v48, v49, "crypto/pkcs7/pk7_doit.c", 645);
                  ek = 0LL;
                  CRYPTO_clear_free(tkey, v46, "crypto/pkcs7/pk7_doit.c", 647);
                  v11 = out;
                  if ( out )
                    BIO_push(out, (BIO *)propq);
                  else
                    v11 = (BIO *)propq;
                  v16 = evp_cipher;
                  v33 = in_bioa;
                  if ( !in_bioa )
                  {
LABEL_92:
                    if ( data_body->length <= 0 )
                    {
                      v51 = BIO_s_mem();
                      v52 = BIO_new(v51);
                      if ( !v52 )
                      {
LABEL_97:
                        propq = 0LL;
                        v17 = 0LL;
                        v36 = 0LL;
                        LODWORD(v37) = tkeylen;
                        goto err;
                      }
                      v33 = v52;
                      BIO_ctrl(v52, 130, 0LL, 0LL);
                    }
                    else
                    {
                      v33 = BIO_new_mem_buf(data_body->data, data_body->length);
                      if ( !v33 )
                        goto LABEL_97;
                    }
                  }
LABEL_45:
                  BIO_push(v11, v33);
                  EVP_CIPHER_free(v16);
                  return v11;
                }
              }
              else
              {
                ERR_new();
                v34 = 554;
LABEL_48:
                ERR_set_debug("crypto/pkcs7/pk7_doit.c", v34, "PKCS7_dataDecode");
                propq = 0LL;
                ERR_set_error(33, 524320, 0LL);
              }
              v17 = 0LL;
LABEL_64:
              v36 = 0LL;
LABEL_65:
              LODWORD(v37) = 0;
              v16 = evp_cipher;
              v11 = out;
              goto err;
            }
            v16 = evp_cipher;
            v33 = in_bioa;
            v11 = out;
            if ( !in_bioa )
              goto LABEL_92;
            goto LABEL_45;
          }
LABEL_16:
          if ( !octet_string )
          {
            ERR_new();
            ERR_set_debug("crypto/pkcs7/pk7_doit.c", 509, "PKCS7_dataDecode");
            propq = 0LL;
            ERR_set_error(33, 122, 0LL);
            v17 = 0LL;
LABEL_54:
            v36 = 0LL;
            LODWORD(v37) = 0;
            v11 = 0LL;
err:
            EVP_CIPHER_free(v16);
            CRYPTO_clear_free(ek, eklen, "crypto/pkcs7/pk7_doit.c", 681);
            CRYPTO_clear_free(v36, (int)v37, "crypto/pkcs7/pk7_doit.c", 682);
            BIO_free_all(v11);
            BIO_free_all(v17);
            BIO_free_all((BIO *)propq);
            v11 = 0LL;
            BIO_free_all(0LL);
            return v11;
          }
          goto LABEL_25;
        default:
          ERR_new();
          ERR_set_debug("crypto/pkcs7/pk7_doit.c", 502, "PKCS7_dataDecode");
          propq = 0LL;
          v10 = 112;
          goto LABEL_53;
      }
      ERR_set_debug("crypto/pkcs7/pk7_doit.c", v35, "PKCS7_dataDecode");
      propq = 0LL;
      v10 = 111;
      goto LABEL_53;
    }
    ERR_new();
    ERR_set_debug("crypto/pkcs7/pk7_doit.c", 430, "PKCS7_dataDecode");
    v11 = 0LL;
    v12 = 122;
  }
  else
  {
    ERR_new();
    ERR_set_debug("crypto/pkcs7/pk7_doit.c", 421, "PKCS7_dataDecode");
    v11 = 0LL;
    v12 = 143;
  }
  ERR_set_error(33, v12, 0LL);
  return v11;
}


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


int __fastcall PKCS7_dataVerify(
        X509_STORE *cert_store,
        X509_STORE_CTX *ctx,
        BIO *bio,
        PKCS7 *p7,
        PKCS7_SIGNER_INFO *si_0)
{
  stack_st_X509 *v8;
  X509_0 *v9;
  X509 *v10;
  int v12;
  int v13;
  PKCS7_SIGNER_INFO *si_0a;
  BIO *bioa;

  if ( p7 )
  {
    if ( p7->d.ptr )
    {
      if ( OBJ_obj2nid(p7->type) == 22 || OBJ_obj2nid(p7->type) == 24 )
      {
        bioa = bio;
        v8 = (stack_st_X509 *)*((_QWORD *)p7->d.ptr + 2);
        si_0a = si_0;
        v9 = (X509_0 *)X509_find_by_issuer_and_serial(
                         v8,
                         si_0->issuer_and_serial->issuer,
                         si_0->issuer_and_serial->serial);
        if ( v9 )
        {
          v10 = (X509 *)v9;
          if ( X509_STORE_CTX_init((X509_STORE_CTX_1 *)ctx, cert_store, v9, v8) )
          {
            X509_STORE_CTX_set_purpose((X509_STORE_CTX_1 *)ctx, 4);
            if ( X509_verify_cert((X509_STORE_CTX_1 *)ctx) > 0 )
              return PKCS7_signatureVerify(bioa, p7, si_0a, v10);
            ERR_new();
            v13 = 1030;
          }
          else
          {
            ERR_new();
            v13 = 1024;
          }
          ERR_set_debug("crypto/pkcs7/pk7_doit.c", v13, "PKCS7_dataVerify");
          v12 = 524299;
        }
        else
        {
          ERR_new();
          ERR_set_debug("crypto/pkcs7/pk7_doit.c", 1018, "PKCS7_dataVerify");
          v12 = 106;
        }
      }
      else
      {
        ERR_new();
        ERR_set_debug("crypto/pkcs7/pk7_doit.c", 1008, "PKCS7_dataVerify");
        v12 = 114;
      }
    }
    else
    {
      ERR_new();
      ERR_set_debug("crypto/pkcs7/pk7_doit.c", 994, "PKCS7_dataVerify");
      v12 = 122;
    }
  }
  else
  {
    ERR_new();
    ERR_set_debug("crypto/pkcs7/pk7_doit.c", 989, "PKCS7_dataVerify");
    v12 = 143;
  }
  ERR_set_error(33, v12, 0LL);
  return 0;
}
