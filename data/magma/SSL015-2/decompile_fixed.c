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
