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
