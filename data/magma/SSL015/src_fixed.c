BIO *PKCS7_dataInit(PKCS7 *p7, BIO *bio) {
  int i;
  BIO *out = NULL, *btmp = NULL;
  X509_ALGOR *xa = NULL;
  EVP_CIPHER *fetched_cipher = NULL;
  const EVP_CIPHER *cipher;
  const EVP_CIPHER *evp_cipher = NULL;
  STACK_OF(X509_ALGOR) *md_sk = NULL;
  STACK_OF(PKCS7_RECIP_INFO) *rsk = NULL;
  X509_ALGOR *xalg = NULL;
  PKCS7_RECIP_INFO *ri = NULL;
  ASN1_OCTET_STRING *os = NULL;
  const PKCS7_CTX *p7_ctx;
  OSSL_LIB_CTX *libctx;
  const char *propq;

  if (p7 == NULL) {
    ERR_raise(ERR_LIB_PKCS7, PKCS7_R_INVALID_NULL_POINTER);
    return NULL;
  }
  p7_ctx = ossl_pkcs7_get0_ctx(p7);
  libctx = ossl_pkcs7_ctx_get0_libctx(p7_ctx);
  propq = ossl_pkcs7_ctx_get0_propq(p7_ctx);

  /*
   * The content field in the PKCS7 ContentInfo is optional, but that really
   * only applies to inner content (precisely, detached signatures).
   *
   * When reading content, missing outer content is therefore treated as an
   * error.
   *
   * When creating content, PKCS7_content_new() must be called before
   * calling this method, so a NULL p7->d is always an error.
   */
  if (p7->d.ptr == NULL) {
    ERR_raise(ERR_LIB_PKCS7, PKCS7_R_NO_CONTENT);
    return NULL;
  }

  i = OBJ_obj2nid(p7->type);
  p7->state = PKCS7_S_HEADER;

  switch (i) {
  case NID_pkcs7_signed:
    md_sk = p7->d.sign->md_algs;
    os = PKCS7_get_octet_string(p7->d.sign->contents);
    break;
  case NID_pkcs7_signedAndEnveloped:
    rsk = p7->d.signed_and_enveloped->recipientinfo;
    md_sk = p7->d.signed_and_enveloped->md_algs;
    xalg = p7->d.signed_and_enveloped->enc_data->algorithm;
    evp_cipher = p7->d.signed_and_enveloped->enc_data->cipher;
    if (evp_cipher == NULL) {
      ERR_raise(ERR_LIB_PKCS7, PKCS7_R_CIPHER_NOT_INITIALIZED);
      goto err;
    }
    break;
  case NID_pkcs7_enveloped:
    rsk = p7->d.enveloped->recipientinfo;
    xalg = p7->d.enveloped->enc_data->algorithm;
    evp_cipher = p7->d.enveloped->enc_data->cipher;
    if (evp_cipher == NULL) {
      ERR_raise(ERR_LIB_PKCS7, PKCS7_R_CIPHER_NOT_INITIALIZED);
      goto err;
    }
    break;
  case NID_pkcs7_digest:
    xa = p7->d.digest->md;
    os = PKCS7_get_octet_string(p7->d.digest->contents);
    break;
  case NID_pkcs7_data:
    break;
  default:
    ERR_raise(ERR_LIB_PKCS7, PKCS7_R_UNSUPPORTED_CONTENT_TYPE);
    goto err;
  }

  for (i = 0; i < sk_X509_ALGOR_num(md_sk); i++)
    if (!pkcs7_bio_add_digest(&out, sk_X509_ALGOR_value(md_sk, i), p7_ctx))
      goto err;

  if (xa && !pkcs7_bio_add_digest(&out, xa, p7_ctx))
    goto err;

  if (evp_cipher != NULL) {
    unsigned char key[EVP_MAX_KEY_LENGTH];
    unsigned char iv[EVP_MAX_IV_LENGTH];
    int keylen, ivlen;
    EVP_CIPHER_CTX *ctx;

    if ((btmp = BIO_new(BIO_f_cipher())) == NULL) {
      ERR_raise(ERR_LIB_PKCS7, ERR_R_BIO_LIB);
      goto err;
    }
    BIO_get_cipher_ctx(btmp, &ctx);
    keylen = EVP_CIPHER_get_key_length(evp_cipher);
    ivlen = EVP_CIPHER_get_iv_length(evp_cipher);
    xalg->algorithm = OBJ_nid2obj(EVP_CIPHER_get_type(evp_cipher));
    if (ivlen > 0)
      if (RAND_bytes_ex(libctx, iv, ivlen, 0) <= 0)
        goto err;

    (void)ERR_set_mark();
    fetched_cipher =
        EVP_CIPHER_fetch(libctx, EVP_CIPHER_get0_name(evp_cipher), propq);
    (void)ERR_pop_to_mark();
    if (fetched_cipher != NULL)
      cipher = fetched_cipher;
    else
      cipher = evp_cipher;

    if (EVP_CipherInit_ex(ctx, cipher, NULL, NULL, NULL, 1) <= 0)
      goto err;

    EVP_CIPHER_free(fetched_cipher);
    fetched_cipher = NULL;

    if (EVP_CIPHER_CTX_rand_key(ctx, key) <= 0)
      goto err;
    if (EVP_CipherInit_ex(ctx, NULL, NULL, key, iv, 1) <= 0)
      goto err;

    if (ivlen > 0) {
      if (xalg->parameter == NULL) {
        xalg->parameter = ASN1_TYPE_new();
        if (xalg->parameter == NULL)
          goto err;
      }
      if (EVP_CIPHER_param_to_asn1(ctx, xalg->parameter) < 0)
        goto err;
    }

    /* Lets do the pub key stuff :-) */
    for (i = 0; i < sk_PKCS7_RECIP_INFO_num(rsk); i++) {
      ri = sk_PKCS7_RECIP_INFO_value(rsk, i);
      if (pkcs7_encode_rinfo(ri, key, keylen) <= 0)
        goto err;
    }
    OPENSSL_cleanse(key, keylen);

    if (out == NULL)
      out = btmp;
    else
      BIO_push(out, btmp);
    btmp = NULL;
  }

  if (bio == NULL) {
    if (PKCS7_is_detached(p7)) {
      bio = BIO_new(BIO_s_null());
    } else if (os && os->length > 0) {
      bio = BIO_new_mem_buf(os->data, os->length);
    } else {
      bio = BIO_new(BIO_s_mem());
      if (bio == NULL)
        goto err;
      BIO_set_mem_eof_return(bio, 0);
    }
    if (bio == NULL)
      goto err;
  }
  if (out)
    BIO_push(out, bio);
  else
    out = bio;
  return out;

err:
  EVP_CIPHER_free(fetched_cipher);
  BIO_free_all(out);
  BIO_free_all(btmp);
  return NULL;
}
BIO *PKCS7_dataDecode(PKCS7 *p7, EVP_PKEY *pkey, BIO *in_bio, X509 *pcert) {
  int i, len;
  BIO *out = NULL, *btmp = NULL, *etmp = NULL, *bio = NULL;
  X509_ALGOR *xa;
  ASN1_OCTET_STRING *data_body = NULL;
  EVP_MD *evp_md = NULL;
  const EVP_MD *md;
  EVP_CIPHER *evp_cipher = NULL;
  const EVP_CIPHER *cipher = NULL;
  EVP_CIPHER_CTX *evp_ctx = NULL;
  X509_ALGOR *enc_alg = NULL;
  STACK_OF(X509_ALGOR) *md_sk = NULL;
  STACK_OF(PKCS7_RECIP_INFO) *rsk = NULL;
  PKCS7_RECIP_INFO *ri = NULL;
  unsigned char *ek = NULL, *tkey = NULL;
  int eklen = 0, tkeylen = 0;
  char name[OSSL_MAX_NAME_SIZE];
  const PKCS7_CTX *p7_ctx;
  OSSL_LIB_CTX *libctx;
  const char *propq;

  if (p7 == NULL) {
    ERR_raise(ERR_LIB_PKCS7, PKCS7_R_INVALID_NULL_POINTER);
    return NULL;
  }

  p7_ctx = ossl_pkcs7_get0_ctx(p7);
  libctx = ossl_pkcs7_ctx_get0_libctx(p7_ctx);
  propq = ossl_pkcs7_ctx_get0_propq(p7_ctx);

  if (p7->d.ptr == NULL) {
    ERR_raise(ERR_LIB_PKCS7, PKCS7_R_NO_CONTENT);
    return NULL;
  }

  i = OBJ_obj2nid(p7->type);
  p7->state = PKCS7_S_HEADER;

  switch (i) {
  case NID_pkcs7_signed:
    /*
     * p7->d.sign->contents is a PKCS7 structure consisting of a contentType
     * field and optional content.
     * data_body is NULL if that structure has no (=detached) content
     * or if the contentType is wrong (i.e., not "data").
     */
    data_body = PKCS7_get_octet_string(p7->d.sign->contents);
    if (!PKCS7_is_detached(p7) && data_body == NULL) {
      ERR_raise(ERR_LIB_PKCS7, PKCS7_R_INVALID_SIGNED_DATA_TYPE);
      goto err;
    }
    md_sk = p7->d.sign->md_algs;
    break;
  case NID_pkcs7_signedAndEnveloped:
    rsk = p7->d.signed_and_enveloped->recipientinfo;
    md_sk = p7->d.signed_and_enveloped->md_algs;
    /* data_body is NULL if the optional EncryptedContent is missing. */
    data_body = p7->d.signed_and_enveloped->enc_data->enc_data;
    enc_alg = p7->d.signed_and_enveloped->enc_data->algorithm;

    OBJ_obj2txt(name, sizeof(name), enc_alg->algorithm, 0);

    (void)ERR_set_mark();
    evp_cipher = EVP_CIPHER_fetch(libctx, name, propq);
    if (evp_cipher != NULL)
      cipher = evp_cipher;
    else
      cipher = EVP_get_cipherbyname(name);

    if (cipher == NULL) {
      (void)ERR_clear_last_mark();
      ERR_raise(ERR_LIB_PKCS7, PKCS7_R_UNSUPPORTED_CIPHER_TYPE);
      goto err;
    }
    (void)ERR_pop_to_mark();
    break;
  case NID_pkcs7_enveloped:
    rsk = p7->d.enveloped->recipientinfo;
    enc_alg = p7->d.enveloped->enc_data->algorithm;
    /* data_body is NULL if the optional EncryptedContent is missing. */
    data_body = p7->d.enveloped->enc_data->enc_data;
    OBJ_obj2txt(name, sizeof(name), enc_alg->algorithm, 0);

    (void)ERR_set_mark();
    evp_cipher = EVP_CIPHER_fetch(libctx, name, propq);
    if (evp_cipher != NULL)
      cipher = evp_cipher;
    else
      cipher = EVP_get_cipherbyname(name);

    if (cipher == NULL) {
      (void)ERR_clear_last_mark();
      ERR_raise(ERR_LIB_PKCS7, PKCS7_R_UNSUPPORTED_CIPHER_TYPE);
      goto err;
    }
    (void)ERR_pop_to_mark();
    break;
  default:
    ERR_raise(ERR_LIB_PKCS7, PKCS7_R_UNSUPPORTED_CONTENT_TYPE);
    goto err;
  }

  /* Detached content must be supplied via in_bio instead. */
  if (data_body == NULL && in_bio == NULL) {
    ERR_raise(ERR_LIB_PKCS7, PKCS7_R_NO_CONTENT);
    goto err;
  }

  /* We will be checking the signature */
  if (md_sk != NULL) {
    for (i = 0; i < sk_X509_ALGOR_num(md_sk); i++) {
      xa = sk_X509_ALGOR_value(md_sk, i);
      if ((btmp = BIO_new(BIO_f_md())) == NULL) {
        ERR_raise(ERR_LIB_PKCS7, ERR_R_BIO_LIB);
        goto err;
      }

      OBJ_obj2txt(name, sizeof(name), xa->algorithm, 0);

      (void)ERR_set_mark();
      evp_md = EVP_MD_fetch(libctx, name, propq);
      if (evp_md != NULL)
        md = evp_md;
      else
        md = EVP_get_digestbyname(name);

      if (md == NULL) {
        (void)ERR_clear_last_mark();
        ERR_raise(ERR_LIB_PKCS7, PKCS7_R_UNKNOWN_DIGEST_TYPE);
        goto err;
      }
      (void)ERR_pop_to_mark();

      BIO_set_md(btmp, md);
      EVP_MD_free(evp_md);
      if (out == NULL)
        out = btmp;
      else
        BIO_push(out, btmp);
      btmp = NULL;
    }
  }

  if (cipher != NULL) {
    if ((etmp = BIO_new(BIO_f_cipher())) == NULL) {
      ERR_raise(ERR_LIB_PKCS7, ERR_R_BIO_LIB);
      goto err;
    }

    /*
     * It was encrypted, we need to decrypt the secret key with the
     * private key
     */

    /*
     * Find the recipientInfo which matches the passed certificate (if
     * any)
     */

    if (pcert) {
      for (i = 0; i < sk_PKCS7_RECIP_INFO_num(rsk); i++) {
        ri = sk_PKCS7_RECIP_INFO_value(rsk, i);
        if (!pkcs7_cmp_ri(ri, pcert))
          break;
        ri = NULL;
      }
      if (ri == NULL) {
        ERR_raise(ERR_LIB_PKCS7, PKCS7_R_NO_RECIPIENT_MATCHES_CERTIFICATE);
        goto err;
      }
    }

    /* If we haven't got a certificate try each ri in turn */
    if (pcert == NULL) {
      /*
       * Always attempt to decrypt all rinfo even after success as a
       * defence against MMA timing attacks.
       */
      for (i = 0; i < sk_PKCS7_RECIP_INFO_num(rsk); i++) {
        ri = sk_PKCS7_RECIP_INFO_value(rsk, i);
        ri->ctx = p7_ctx;
        if (pkcs7_decrypt_rinfo(&ek, &eklen, ri, pkey,
                                EVP_CIPHER_get_key_length(cipher)) < 0)
          goto err;
        ERR_clear_error();
      }
    } else {
      ri->ctx = p7_ctx;
      /* Only exit on fatal errors, not decrypt failure */
      if (pkcs7_decrypt_rinfo(&ek, &eklen, ri, pkey, 0) < 0)
        goto err;
      ERR_clear_error();
    }

    evp_ctx = NULL;
    BIO_get_cipher_ctx(etmp, &evp_ctx);
    if (EVP_CipherInit_ex(evp_ctx, cipher, NULL, NULL, NULL, 0) <= 0)
      goto err;
    if (EVP_CIPHER_asn1_to_param(evp_ctx, enc_alg->parameter) < 0)
      goto err;
    /* Generate random key as MMA defence */
    len = EVP_CIPHER_CTX_get_key_length(evp_ctx);
    if (len <= 0)
      goto err;
    tkeylen = (size_t)len;
    tkey = OPENSSL_malloc(tkeylen);
    if (tkey == NULL)
      goto err;
    if (EVP_CIPHER_CTX_rand_key(evp_ctx, tkey) <= 0)
      goto err;
    if (ek == NULL) {
      ek = tkey;
      eklen = tkeylen;
      tkey = NULL;
    }

    if (eklen != EVP_CIPHER_CTX_get_key_length(evp_ctx)) {
      /*
       * Some S/MIME clients don't use the same key and effective key
       * length. The key length is determined by the size of the
       * decrypted RSA key.
       */
      if (!EVP_CIPHER_CTX_set_key_length(evp_ctx, eklen)) {
        /* Use random key as MMA defence */
        OPENSSL_clear_free(ek, eklen);
        ek = tkey;
        eklen = tkeylen;
        tkey = NULL;
      }
    }
    /* Clear errors so we don't leak information useful in MMA */
    ERR_clear_error();
    if (EVP_CipherInit_ex(evp_ctx, NULL, NULL, ek, NULL, 0) <= 0)
      goto err;

    OPENSSL_clear_free(ek, eklen);
    ek = NULL;
    OPENSSL_clear_free(tkey, tkeylen);
    tkey = NULL;

    if (out == NULL)
      out = etmp;
    else
      BIO_push(out, etmp);
    etmp = NULL;
  }
  if (in_bio != NULL) {
    bio = in_bio;
  } else {
    if (data_body->length > 0)
      bio = BIO_new_mem_buf(data_body->data, data_body->length);
    else {
      bio = BIO_new(BIO_s_mem());
      if (bio == NULL)
        goto err;
      BIO_set_mem_eof_return(bio, 0);
    }
    if (bio == NULL)
      goto err;
  }
  BIO_push(out, bio);
  bio = NULL;
  EVP_CIPHER_free(evp_cipher);
  return out;

err:
  EVP_CIPHER_free(evp_cipher);
  OPENSSL_clear_free(ek, eklen);
  OPENSSL_clear_free(tkey, tkeylen);
  BIO_free_all(out);
  BIO_free_all(btmp);
  BIO_free_all(etmp);
  BIO_free_all(bio);
  return NULL;
}
int PKCS7_dataFinal(PKCS7 *p7, BIO *bio) {
  int ret = 0;
  int i, j;
  BIO *btmp;
  PKCS7_SIGNER_INFO *si;
  EVP_MD_CTX *mdc, *ctx_tmp;
  STACK_OF(X509_ATTRIBUTE) * sk;
  STACK_OF(PKCS7_SIGNER_INFO) *si_sk = NULL;
  ASN1_OCTET_STRING *os = NULL;
  const PKCS7_CTX *p7_ctx;

  if (p7 == NULL) {
    ERR_raise(ERR_LIB_PKCS7, PKCS7_R_INVALID_NULL_POINTER);
    return 0;
  }

  p7_ctx = ossl_pkcs7_get0_ctx(p7);

  if (p7->d.ptr == NULL) {
    ERR_raise(ERR_LIB_PKCS7, PKCS7_R_NO_CONTENT);
    return 0;
  }

  ctx_tmp = EVP_MD_CTX_new();
  if (ctx_tmp == NULL) {
    ERR_raise(ERR_LIB_PKCS7, ERR_R_MALLOC_FAILURE);
    return 0;
  }

  i = OBJ_obj2nid(p7->type);
  p7->state = PKCS7_S_HEADER;

  switch (i) {
  case NID_pkcs7_data:
    os = p7->d.data;
    break;
  case NID_pkcs7_signedAndEnveloped:
    /* XXXXXXXXXXXXXXXX */
    si_sk = p7->d.signed_and_enveloped->signer_info;
    os = p7->d.signed_and_enveloped->enc_data->enc_data;
    if (os == NULL) {
      os = ASN1_OCTET_STRING_new();
      if (os == NULL) {
        ERR_raise(ERR_LIB_PKCS7, ERR_R_MALLOC_FAILURE);
        goto err;
      }
      p7->d.signed_and_enveloped->enc_data->enc_data = os;
    }
    break;
  case NID_pkcs7_enveloped:
    /* XXXXXXXXXXXXXXXX */
    os = p7->d.enveloped->enc_data->enc_data;
    if (os == NULL) {
      os = ASN1_OCTET_STRING_new();
      if (os == NULL) {
        ERR_raise(ERR_LIB_PKCS7, ERR_R_MALLOC_FAILURE);
        goto err;
      }
      p7->d.enveloped->enc_data->enc_data = os;
    }
    break;
  case NID_pkcs7_signed:
    si_sk = p7->d.sign->signer_info;
    os = PKCS7_get_octet_string(p7->d.sign->contents);
    /* If detached data then the content is excluded */
    if (PKCS7_type_is_data(p7->d.sign->contents) && p7->detached) {
      ASN1_OCTET_STRING_free(os);
      os = NULL;
      p7->d.sign->contents->d.data = NULL;
    }
    break;

  case NID_pkcs7_digest:
    os = PKCS7_get_octet_string(p7->d.digest->contents);
    /* If detached data then the content is excluded */
    if (PKCS7_type_is_data(p7->d.digest->contents) && p7->detached) {
      ASN1_OCTET_STRING_free(os);
      os = NULL;
      p7->d.digest->contents->d.data = NULL;
    }
    break;

  default:
    ERR_raise(ERR_LIB_PKCS7, PKCS7_R_UNSUPPORTED_CONTENT_TYPE);
    goto err;
  }

  if (si_sk != NULL) {
    for (i = 0; i < sk_PKCS7_SIGNER_INFO_num(si_sk); i++) {
      si = sk_PKCS7_SIGNER_INFO_value(si_sk, i);
      if (si->pkey == NULL)
        continue;

      j = OBJ_obj2nid(si->digest_alg->algorithm);

      btmp = bio;

      btmp = PKCS7_find_digest(&mdc, btmp, j);

      if (btmp == NULL)
        goto err;

      /*
       * We now have the EVP_MD_CTX, lets do the signing.
       */
      if (!EVP_MD_CTX_copy_ex(ctx_tmp, mdc))
        goto err;

      sk = si->auth_attr;

      /*
       * If there are attributes, we add the digest attribute and only
       * sign the attributes
       */
      if (sk_X509_ATTRIBUTE_num(sk) > 0) {
        if (!do_pkcs7_signed_attrib(si, ctx_tmp))
          goto err;
      } else {
        unsigned char *abuf = NULL;
        unsigned int abuflen;
        abuflen = EVP_PKEY_get_size(si->pkey);
        abuf = OPENSSL_malloc(abuflen);
        if (abuf == NULL)
          goto err;

        if (!EVP_SignFinal_ex(ctx_tmp, abuf, &abuflen, si->pkey,
                              ossl_pkcs7_ctx_get0_libctx(p7_ctx),
                              ossl_pkcs7_ctx_get0_propq(p7_ctx))) {
          OPENSSL_free(abuf);
          ERR_raise(ERR_LIB_PKCS7, ERR_R_EVP_LIB);
          goto err;
        }
        ASN1_STRING_set0(si->enc_digest, abuf, abuflen);
      }
    }
  } else if (i == NID_pkcs7_digest) {
    unsigned char md_data[EVP_MAX_MD_SIZE];
    unsigned int md_len;
    if (!PKCS7_find_digest(&mdc, bio, OBJ_obj2nid(p7->d.digest->md->algorithm)))
      goto err;
    if (!EVP_DigestFinal_ex(mdc, md_data, &md_len))
      goto err;
    if (!ASN1_OCTET_STRING_set(p7->d.digest->digest, md_data, md_len))
      goto err;
  }

  if (!PKCS7_is_detached(p7)) {
    /*
     * NOTE(emilia): I think we only reach os == NULL here because detached
     * digested data support is broken.
     */
    if (os == NULL)
      goto err;
    if (!(os->flags & ASN1_STRING_FLAG_NDEF)) {
      char *cont;
      long contlen;
      btmp = BIO_find_type(bio, BIO_TYPE_MEM);
      if (btmp == NULL) {
        ERR_raise(ERR_LIB_PKCS7, PKCS7_R_UNABLE_TO_FIND_MEM_BIO);
        goto err;
      }
      contlen = BIO_get_mem_data(btmp, &cont);
      /*
       * Mark the BIO read only then we can use its copy of the data
       * instead of making an extra copy.
       */
      BIO_set_flags(btmp, BIO_FLAGS_MEM_RDONLY);
      BIO_set_mem_eof_return(btmp, 0);
      ASN1_STRING_set0(os, (unsigned char *)cont, contlen);
    }
  }
  ret = 1;
err:
  EVP_MD_CTX_free(ctx_tmp);
  return ret;
}
int PKCS7_dataVerify(X509_STORE *cert_store, X509_STORE_CTX *ctx, BIO *bio,
                     PKCS7 *p7, PKCS7_SIGNER_INFO *si) {
  PKCS7_ISSUER_AND_SERIAL *ias;
  int ret = 0, i;
  STACK_OF(X509) * cert;
  X509 *x509;

  if (p7 == NULL) {
    ERR_raise(ERR_LIB_PKCS7, PKCS7_R_INVALID_NULL_POINTER);
    return 0;
  }

  if (p7->d.ptr == NULL) {
    ERR_raise(ERR_LIB_PKCS7, PKCS7_R_NO_CONTENT);
    return 0;
  }

  if (PKCS7_type_is_signed(p7)) {
    cert = p7->d.sign->cert;
  } else if (PKCS7_type_is_signedAndEnveloped(p7)) {
    cert = p7->d.signed_and_enveloped->cert;
  } else {
    ERR_raise(ERR_LIB_PKCS7, PKCS7_R_WRONG_PKCS7_TYPE);
    goto err;
  }
  /* XXXXXXXXXXXXXXXXXXXXXXX */
  ias = si->issuer_and_serial;

  x509 = X509_find_by_issuer_and_serial(cert, ias->issuer, ias->serial);

  /* were we able to find the cert in passed to us */
  if (x509 == NULL) {
    ERR_raise(ERR_LIB_PKCS7, PKCS7_R_UNABLE_TO_FIND_CERTIFICATE);
    goto err;
  }

  /* Lets verify */
  if (!X509_STORE_CTX_init(ctx, cert_store, x509, cert)) {
    ERR_raise(ERR_LIB_PKCS7, ERR_R_X509_LIB);
    goto err;
  }
  X509_STORE_CTX_set_purpose(ctx, X509_PURPOSE_SMIME_SIGN);
  i = X509_verify_cert(ctx);
  if (i <= 0) {
    ERR_raise(ERR_LIB_PKCS7, ERR_R_X509_LIB);
    goto err;
  }

  return PKCS7_signatureVerify(bio, p7, si, x509);
err:
  return ret;
}
