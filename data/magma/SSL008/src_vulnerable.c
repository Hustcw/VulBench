static int tls_construct_cke_dhe(SSL *s, WPACKET *pkt) {
  EVP_PKEY *ckey = NULL, *skey = NULL;
  unsigned char *keybytes = NULL;
  int prime_len;
  unsigned char *encoded_pub = NULL;
  size_t encoded_pub_len, pad_len;
  int ret = 0;

  skey = s->s3.peer_tmp;
  if (skey == NULL) {
    SSLfatal(s, SSL_AD_INTERNAL_ERROR, ERR_R_INTERNAL_ERROR);
    goto err;
  }

  ckey = ssl_generate_pkey(s, skey);

  if (ssl_derive(s, ckey, skey, 0) == 0) {
    /* SSLfatal() already called */
    goto err;
  }

  /* send off the data */

  /* Generate encoding of server key */
  encoded_pub_len = EVP_PKEY_get1_encoded_public_key(ckey, &encoded_pub);
  if (encoded_pub_len == 0) {
    SSLfatal(s, SSL_AD_INTERNAL_ERROR, ERR_R_INTERNAL_ERROR);
    EVP_PKEY_free(skey);
    return EXT_RETURN_FAIL;
  }

  /*
   * For interoperability with some versions of the Microsoft TLS
   * stack, we need to zero pad the DHE pub key to the same length
   * as the prime.
   */
  prime_len = EVP_PKEY_get_size(ckey);
  pad_len = prime_len - encoded_pub_len;
  if (pad_len > 0) {
    if (!WPACKET_sub_allocate_bytes_u16(pkt, pad_len, &keybytes)) {
      SSLfatal(s, SSL_AD_INTERNAL_ERROR, ERR_R_INTERNAL_ERROR);
      goto err;
    }
    memset(keybytes, 0, pad_len);
  }

  if (!WPACKET_sub_memcpy_u16(pkt, encoded_pub, encoded_pub_len)) {
    SSLfatal(s, SSL_AD_INTERNAL_ERROR, ERR_R_INTERNAL_ERROR);
    goto err;
  }

  ret = 1;
err:
  OPENSSL_free(encoded_pub);
  EVP_PKEY_free(ckey);
  return ret;
}

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
#ifdef MAGMA_ENABLE_CANARIES
  MAGMA_LOG("%MAGMA_BUG%", ckey == NULL);
#endif

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

