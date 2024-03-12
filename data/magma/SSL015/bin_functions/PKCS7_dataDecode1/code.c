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
