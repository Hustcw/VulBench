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


BIO *__fastcall PKCS7_dataDecode(PKCS7 *p7, EVP_PKEY *pkey, BIO *in_bio, X509 *pcert)
{
  int v5;
  ASN1_OCTET_STRING *octet_string;
  __int64 v7;
  BIO *v8;
  int v9;
  union {char *ptr;ASN1_OCTET_STRING *data;PKCS7_SIGNED *sign;PKCS7_ENVELOPE *enveloped;PKCS7_SIGN_ENVELOPE *signed_and_enveloped;PKCS7_DIGEST *digest;PKCS7_ENCRYPT *encrypted;ASN1_TYPE *other;} v10;
  const stack_st_X509_ALGOR *v11;
  __int64 v12;
  X509_ALGOR *v13;
  const char *v14;
  EVP_CIPHER *v15;
  union {char *ptr;ASN1_OCTET_STRING *data;PKCS7_SIGNED *sign;PKCS7_ENVELOPE *enveloped;PKCS7_SIGN_ENVELOPE *signed_and_enveloped;PKCS7_DIGEST *digest;PKCS7_ENCRYPT *encrypted;ASN1_TYPE *other;} v16;
  __int64 v17;
  X509_ALGOR *v18;
  const char *v19;
  EVP_CIPHER *v20;
  BIO *v21;
  OPENSSL_STACK *v22;
  int v23;
  const ASN1_OBJECT **v24;
  const BIO_METHOD *v25;
  BIO *v26;
  const char *v27;
  EVP_MD *v28;
  EVP_MD *digestbyname;
  BIO *v30;
  const BIO_METHOD *v31;
  BIO *v32;
  BIO *v33;
  const OPENSSL_STACK *v34;
  int v35;
  PKCS7_RECIP_INFO *v36;
  unsigned __int8 *v37;
  int v38;
  int v39;
  EVP_CIPHER *v40;
  const OPENSSL_STACK *v41;
  int v42;
  PKCS7_RECIP_INFO *v43;
  int key_length;
  int v45;
  __int64 v46;
  size_t v47;
  unsigned __int8 *v48;
  unsigned __int8 *v49;
  int v50;
  int v52;
  PKCS7 *v53;
  __int64 v54;
  const BIO_METHOD *v55;
  BIO *v56;
  char name[50];
  EVP_PKEY *pkeya;
  X509 *pcerta;
  PKCS7 *p7a;
  X509_ALGOR *enc_alg;
  ASN1_OCTET_STRING *data_body;
  stack_st_PKCS7_RECIP_INFO *rsk;
  BIO *in_bioa;
  __int64 tkeylen;
  unsigned __int8 *ek;
  const EVP_CIPHER *cipher;
  BIO *b;
  void *parg;
  int eklen;
  OPENSSL_STACK *st;
  EVP_CIPHER *evp_cipher;
  BIO *btmp;

  pcerta = pcert;
  pkeya = pkey;
  parg = 0LL;
  ek = 0LL;
  eklen = 0;
  v5 = OBJ_obj2nid(p7->type);
  p7->state = 0;
  if ( v5 == 24 )
  {
    p7a = p7;
    v10.ptr = (char *)p7->d;
    rsk = (stack_st_PKCS7_RECIP_INFO *)*((_QWORD *)v10.ptr + 6);
    v11 = (const stack_st_X509_ALGOR *)*((_QWORD *)v10.ptr + 1);
    v12 = *((_QWORD *)v10.ptr + 5);
    v13 = *(X509_ALGOR **)(v12 + 8);
    data_body = *(ASN1_OCTET_STRING **)(v12 + 16);
    enc_alg = v13;
    OBJ_obj2txt(name, 50, v13->algorithm, 0);
    ERR_set_mark();
    v15 = EVP_CIPHER_fetch((OSSL_LIB_CTX *)name, name, v14);
    cipher = v15;
    if ( v15 || (cipher = EVP_get_cipherbyname(name)) != 0LL )
    {
      ERR_pop_to_mark();
      goto LABEL_17;
    }
    ERR_clear_last_mark();
    ERR_new();
    v50 = 475;
LABEL_59:
    ERR_set_debug("crypto/pkcs7/pk7_doit.c", v50, "PKCS7_dataDecode");
    v8 = 0LL;
    v9 = 111;
    goto LABEL_60;
  }
  if ( v5 == 23 )
  {
    p7a = p7;
    v16.ptr = (char *)p7->d;
    rsk = (stack_st_PKCS7_RECIP_INFO *)*((_QWORD *)v16.ptr + 1);
    v17 = *((_QWORD *)v16.ptr + 2);
    v18 = *(X509_ALGOR **)(v17 + 8);
    data_body = *(ASN1_OCTET_STRING **)(v17 + 16);
    enc_alg = v18;
    OBJ_obj2txt(name, 50, v18->algorithm, 0);
    ERR_set_mark();
    v20 = EVP_CIPHER_fetch((OSSL_LIB_CTX *)name, name, v19);
    cipher = v20;
    if ( v20 || (cipher = EVP_get_cipherbyname(name)) != 0LL )
    {
      evp_cipher = v20;
      ERR_pop_to_mark();
      v21 = 0LL;
      goto LABEL_29;
    }
    ERR_clear_last_mark();
    ERR_new();
    v50 = 496;
    goto LABEL_59;
  }
  if ( v5 != 22 )
  {
    ERR_new();
    ERR_set_debug("crypto/pkcs7/pk7_doit.c", 502, "PKCS7_dataDecode");
    v8 = 0LL;
    v9 = 112;
    goto LABEL_60;
  }
  octet_string = PKCS7_get_octet_string(*((PKCS7 **)p7->d.ptr + 5));
  if ( OBJ_obj2nid(p7->type) == 22 )
  {
    v7 = PKCS7_ctrl((PKCS7_0 *)p7, 2, 0LL, 0LL);
    if ( !octet_string && !v7 )
      goto LABEL_7;
  }
  else if ( !octet_string )
  {
LABEL_7:
    ERR_new();
    ERR_set_debug("crypto/pkcs7/pk7_doit.c", 452, "PKCS7_dataDecode");
    v8 = 0LL;
    v9 = 155;
LABEL_60:
    ERR_set_error(33, v9, 0LL);
    btmp = 0LL;
    v33 = 0LL;
    v40 = 0LL;
    v37 = 0LL;
LABEL_61:
    v38 = 0;
    goto err;
  }
  data_body = octet_string;
  p7a = p7;
  v11 = (const stack_st_X509_ALGOR *)*((_QWORD *)p7->d.ptr + 1);
  v15 = 0LL;
  cipher = 0LL;
  enc_alg = 0LL;
  rsk = 0LL;
LABEL_17:
  in_bioa = in_bio;
  tkeylen = 0LL;
  evp_cipher = v15;
  if ( v11 )
  {
    v22 = (OPENSSL_STACK *)ossl_check_const_X509_ALGOR_sk_type(v11);
    v23 = 0;
    v21 = 0LL;
    if ( OPENSSL_sk_num(v22) > 0 )
    {
      st = v22;
      while ( 1 )
      {
        v24 = (const ASN1_OBJECT **)OPENSSL_sk_value(v22, v23);
        v25 = BIO_f_md();
        v26 = BIO_new(v25);
        if ( !v26 )
        {
          ERR_new();
          ERR_set_debug("crypto/pkcs7/pk7_doit.c", 522, "PKCS7_dataDecode");
          btmp = 0LL;
          v39 = 524320;
          goto LABEL_69;
        }
        btmp = v26;
        OBJ_obj2txt(name, 50, *v24, 0);
        ERR_set_mark();
        v28 = EVP_MD_fetch((OSSL_LIB_CTX *)name, name, v27);
        digestbyname = v28;
        if ( !v28 )
        {
          digestbyname = (EVP_MD *)EVP_get_digestbyname(name);
          if ( !digestbyname )
            break;
        }
        ERR_pop_to_mark();
        v30 = btmp;
        BIO_ctrl(btmp, 111, 0LL, digestbyname);
        EVP_MD_free(v28);
        if ( v21 )
          BIO_push(v21, v30);
        else
          v21 = v30;
        v22 = st;
        if ( ++v23 >= OPENSSL_sk_num(st) )
          goto LABEL_28;
      }
      ERR_clear_last_mark();
      ERR_new();
      ERR_set_debug("crypto/pkcs7/pk7_doit.c", 537, "PKCS7_dataDecode");
      v39 = 109;
LABEL_69:
      ERR_set_error(33, v39, 0LL);
      v37 = 0LL;
      v38 = 0;
      v40 = evp_cipher;
      v8 = v21;
      v33 = 0LL;
      goto err;
    }
  }
  else
  {
    v21 = 0LL;
  }
LABEL_28:
  in_bio = in_bioa;
  if ( !cipher )
    goto LABEL_84;
LABEL_29:
  v31 = BIO_f_cipher();
  v32 = BIO_new(v31);
  if ( v32 )
  {
    in_bioa = in_bio;
    st = (OPENSSL_STACK *)v21;
    v33 = v32;
    if ( pcerta )
    {
      v34 = ossl_check_const_PKCS7_RECIP_INFO_sk_type(rsk);
      if ( OPENSSL_sk_num(v34) <= 0 )
        goto LABEL_42;
      v35 = 0;
      while ( 1 )
      {
        v36 = (PKCS7_RECIP_INFO *)OPENSSL_sk_value(v34, v35);
        if ( !pkcs7_cmp_ri(v36, pcerta) )
          break;
        if ( ++v35 >= OPENSSL_sk_num(v34) )
          goto LABEL_42;
      }
      if ( !v36 )
      {
LABEL_42:
        ERR_new();
        ERR_set_debug("crypto/pkcs7/pk7_doit.c", 577, "PKCS7_dataDecode");
        btmp = 0LL;
        ERR_set_error(33, 115, 0LL);
        v37 = 0LL;
        goto LABEL_43;
      }
      if ( pcerta )
      {
        if ( pkcs7_decrypt_rinfo(&ek, &eklen, v36, pkeya, 0LL) >= 0 )
        {
          b = v33;
          ERR_clear_error();
          goto LABEL_50;
        }
        v37 = 0LL;
        btmp = 0LL;
LABEL_43:
        v38 = 0;
LABEL_44:
        v8 = (BIO *)st;
        goto LABEL_45;
      }
    }
    b = v33;
    v41 = ossl_check_const_PKCS7_RECIP_INFO_sk_type(rsk);
    if ( OPENSSL_sk_num(v41) > 0 )
    {
      v42 = 0;
      while ( 1 )
      {
        v43 = (PKCS7_RECIP_INFO *)OPENSSL_sk_value(v41, v42);
        key_length = EVP_CIPHER_get_key_length(cipher);
        if ( pkcs7_decrypt_rinfo(&ek, &eklen, v43, pkeya, key_length) < 0 )
          break;
        ERR_clear_error();
        if ( ++v42 >= OPENSSL_sk_num(v41) )
          goto LABEL_50;
      }
      btmp = 0LL;
      v37 = 0LL;
      v40 = evp_cipher;
      v8 = (BIO *)st;
      v33 = b;
      goto LABEL_61;
    }
LABEL_50:
    parg = 0LL;
    v33 = b;
    BIO_ctrl(b, 129, 0LL, &parg);
    if ( EVP_CipherInit_ex((EVP_CIPHER_CTX_0 *)parg, cipher, 0LL, 0LL, 0LL, 0) <= 0 )
    {
      v37 = 0LL;
      btmp = 0LL;
    }
    else
    {
      if ( EVP_CIPHER_asn1_to_param((EVP_CIPHER_CTX *)parg, (ASN1_TYPE_0 *)enc_alg->parameter) >= 0 )
      {
        v45 = EVP_CIPHER_CTX_get_key_length((const EVP_CIPHER_CTX *)parg);
        if ( v45 > 0 )
        {
          v46 = (unsigned int)v45;
          v47 = v45;
          v48 = (unsigned __int8 *)CRYPTO_malloc(v45, "crypto/pkcs7/pk7_doit.c", 615);
          if ( v48 )
          {
            v37 = v48;
            if ( EVP_CIPHER_CTX_rand_key((EVP_CIPHER_CTX_0 *)parg, v48) > 0 )
            {
              v49 = ek;
              tkeylen = v46;
              if ( ek )
              {
                LODWORD(v46) = eklen;
              }
              else
              {
                ek = v37;
                eklen = v46;
                v49 = v37;
                v37 = 0LL;
              }
              v52 = EVP_CIPHER_CTX_get_key_length((const EVP_CIPHER_CTX *)parg);
              b = v33;
              if ( (_DWORD)v46 != v52 && !EVP_CIPHER_CTX_set_key_length((EVP_CIPHER_CTX_0 *)parg, v46) )
              {
                CRYPTO_clear_free(v49, (int)v46, "crypto/pkcs7/pk7_doit.c", 634);
                ek = v37;
                eklen = tkeylen;
                LODWORD(v46) = tkeylen;
                v49 = v37;
                v37 = 0LL;
              }
              ERR_clear_error();
              if ( EVP_CipherInit_ex((EVP_CIPHER_CTX_0 *)parg, 0LL, 0LL, v49, 0LL, 0) <= 0 )
              {
                v8 = (BIO *)st;
                btmp = 0LL;
                v38 = tkeylen;
                v40 = evp_cipher;
                v33 = b;
                goto err;
              }
              CRYPTO_clear_free(v49, (int)v46, "crypto/pkcs7/pk7_doit.c", 645);
              ek = 0LL;
              CRYPTO_clear_free(v37, v47, "crypto/pkcs7/pk7_doit.c", 647);
              v21 = (BIO *)st;
              if ( st )
                BIO_push((BIO *)st, b);
              else
                v21 = b;
              in_bio = in_bioa;
LABEL_84:
              v53 = p7a;
              if ( OBJ_obj2nid(p7a->type) == 22 )
              {
                v54 = PKCS7_ctrl((PKCS7_0 *)v53, 2, 0LL, 0LL);
                if ( in_bio || v54 )
                  goto LABEL_94;
              }
              else if ( in_bio )
              {
                goto LABEL_94;
              }
              if ( data_body->length <= 0 )
              {
                v55 = BIO_s_mem();
                v56 = BIO_new(v55);
                if ( !v56 )
                {
LABEL_95:
                  btmp = 0LL;
                  v37 = 0LL;
                  v8 = v21;
                  v33 = 0LL;
                  v38 = tkeylen;
                  goto LABEL_45;
                }
                in_bio = v56;
                BIO_ctrl(v56, 130, 0LL, 0LL);
              }
              else
              {
                in_bio = BIO_new_mem_buf(data_body->data, data_body->length);
                if ( !in_bio )
                  goto LABEL_95;
              }
LABEL_94:
              BIO_push(v21, in_bio);
              EVP_CIPHER_free(evp_cipher);
              return v21;
            }
            btmp = 0LL;
          }
          else
          {
            btmp = 0LL;
            v37 = 0LL;
          }
          v38 = v46;
          goto LABEL_44;
        }
      }
      btmp = 0LL;
      v37 = 0LL;
    }
    v38 = 0;
    v40 = evp_cipher;
    v8 = (BIO *)st;
    goto err;
  }
  ERR_new();
  ERR_set_debug("crypto/pkcs7/pk7_doit.c", 554, "PKCS7_dataDecode");
  btmp = 0LL;
  ERR_set_error(33, 524320, 0LL);
  v37 = 0LL;
  v38 = 0;
  v8 = v21;
  v33 = 0LL;
LABEL_45:
  v40 = evp_cipher;
err:
  EVP_CIPHER_free(v40);
  CRYPTO_clear_free(ek, eklen, "crypto/pkcs7/pk7_doit.c", 681);
  CRYPTO_clear_free(v37, v38, "crypto/pkcs7/pk7_doit.c", 682);
  BIO_free_all(v8);
  BIO_free_all(btmp);
  BIO_free_all(v33);
  v21 = 0LL;
  BIO_free_all(0LL);
  return v21;
}


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
  BIO *bioa;

  if ( OBJ_obj2nid(p7->type) == 22 || OBJ_obj2nid(p7->type) == 24 )
  {
    bioa = bio;
    v8 = (stack_st_X509 *)*((_QWORD *)p7->d.ptr + 2);
    v9 = (X509_0 *)X509_find_by_issuer_and_serial(v8, si_0->issuer_and_serial->issuer, si_0->issuer_and_serial->serial);
    if ( v9 )
    {
      v10 = (X509 *)v9;
      if ( X509_STORE_CTX_init((X509_STORE_CTX_1 *)ctx, cert_store, v9, v8) )
      {
        X509_STORE_CTX_set_purpose((X509_STORE_CTX_1 *)ctx, 4);
        if ( X509_verify_cert((X509_STORE_CTX_1 *)ctx) > 0 )
          return PKCS7_signatureVerify(bioa, p7, si_0, v10);
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
  ERR_set_error(33, v12, 0LL);
  return 0;
}
