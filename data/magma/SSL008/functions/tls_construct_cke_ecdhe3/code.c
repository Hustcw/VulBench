static int tls_construct_cke_ecdhe(SSL *s, WPACKET *pkt) {
  unsigned char *encodedPoint = NULL;
  size_t encoded_pt_len = 0;
  EVP_PKEY *ckey = NULL, *skey = NULL;
  int ret = 0;

  skey = s->s3.peer_tmp;
  if (skey == NULL) {
    SSLfatal(s, SSL_AD_INTERNAL_ERROR, ERR_R_INTERNAL_ERROR);
    return 0;
  }

  ckey = ssl_generate_pkey(s, skey);

  if (ssl_derive(s, ckey, skey, 0) == 0) {
    /* SSLfatal() already called */
    goto err;
  }

  /* Generate encoding of client key */
  encoded_pt_len = EVP_PKEY_get1_encoded_public_key(ckey, &encodedPoint);

  if (encoded_pt_len == 0) {
    SSLfatal(s, SSL_AD_INTERNAL_ERROR, ERR_R_EC_LIB);
    goto err;
  }

  if (!WPACKET_sub_memcpy_u8(pkt, encodedPoint, encoded_pt_len)) {
    SSLfatal(s, SSL_AD_INTERNAL_ERROR, ERR_R_INTERNAL_ERROR);
    goto err;
  }

  ret = 1;
err:
  OPENSSL_free(encodedPoint);
  EVP_PKEY_free(ckey);
  return ret;
}

