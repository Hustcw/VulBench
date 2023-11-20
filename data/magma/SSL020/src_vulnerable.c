SSL_TICKET_STATUS tls_decrypt_ticket(SSL *s, const unsigned char *etick,
                                     size_t eticklen,
                                     const unsigned char *sess_id,
                                     size_t sesslen, SSL_SESSION **psess) {
  SSL_SESSION *sess = NULL;
  unsigned char *sdec;
  const unsigned char *p;
  int slen, renew_ticket = 0, declen;
  SSL_TICKET_STATUS ret = SSL_TICKET_FATAL_ERR_OTHER;
  size_t mlen;
  unsigned char tick_hmac[EVP_MAX_MD_SIZE];
  SSL_HMAC *hctx = NULL;
  EVP_CIPHER_CTX *ctx = NULL;
  SSL_CTX *tctx = s->session_ctx;

  if (eticklen == 0) {
    /*
     * The client will accept a ticket but doesn't currently have
     * one (TLSv1.2 and below), or treated as a fatal error in TLSv1.3
     */
    ret = SSL_TICKET_EMPTY;
    goto end;
  }
  if (!SSL_IS_TLS13(s) && s->ext.session_secret_cb) {
    /*
     * Indicate that the ticket couldn't be decrypted rather than
     * generating the session from ticket now, trigger
     * abbreviated handshake based on external mechanism to
     * calculate the master secret later.
     */
    ret = SSL_TICKET_NO_DECRYPT;
    goto end;
  }

  /* Need at least keyname + iv */
  if (eticklen < TLSEXT_KEYNAME_LENGTH + EVP_MAX_IV_LENGTH) {
    ret = SSL_TICKET_NO_DECRYPT;
    goto end;
  }

  /* Initialize session ticket encryption and HMAC contexts */
  hctx = ssl_hmac_new(tctx);
  if (hctx == NULL) {
    ret = SSL_TICKET_FATAL_ERR_MALLOC;
    goto end;
  }
  ctx = EVP_CIPHER_CTX_new();
  if (ctx == NULL) {
    ret = SSL_TICKET_FATAL_ERR_MALLOC;
    goto end;
  }
#ifndef OPENSSL_NO_DEPRECATED_3_0
  if (tctx->ext.ticket_key_evp_cb != NULL || tctx->ext.ticket_key_cb != NULL)
#else
  if (tctx->ext.ticket_key_evp_cb != NULL)
#endif
  {
    unsigned char *nctick = (unsigned char *)etick;
    int rv = 0;

    if (tctx->ext.ticket_key_evp_cb != NULL)
      rv =
          tctx->ext.ticket_key_evp_cb(s, nctick, nctick + TLSEXT_KEYNAME_LENGTH,
                                      ctx, ssl_hmac_get0_EVP_MAC_CTX(hctx), 0);
#ifndef OPENSSL_NO_DEPRECATED_3_0
    else if (tctx->ext.ticket_key_cb != NULL)
      /* if 0 is returned, write an empty ticket */
      rv = tctx->ext.ticket_key_cb(s, nctick, nctick + TLSEXT_KEYNAME_LENGTH,
                                   ctx, ssl_hmac_get0_HMAC_CTX(hctx), 0);
#endif
    if (rv < 0) {
      ret = SSL_TICKET_FATAL_ERR_OTHER;
      goto end;
    }
    if (rv == 0) {
      ret = SSL_TICKET_NO_DECRYPT;
      goto end;
    }
    if (rv == 2)
      renew_ticket = 1;
  } else {
    EVP_CIPHER *aes256cbc = NULL;

    /* Check key name matches */
    if (memcmp(etick, tctx->ext.tick_key_name, TLSEXT_KEYNAME_LENGTH) != 0) {
      ret = SSL_TICKET_NO_DECRYPT;
      goto end;
    }

    aes256cbc = EVP_CIPHER_fetch(s->ctx->libctx, "AES-256-CBC", s->ctx->propq);
    if (aes256cbc == NULL ||
        ssl_hmac_init(hctx, tctx->ext.secure->tick_hmac_key,
                      sizeof(tctx->ext.secure->tick_hmac_key), "SHA256") <= 0 ||
        EVP_DecryptInit_ex(ctx, aes256cbc, NULL, tctx->ext.secure->tick_aes_key,
                           etick + TLSEXT_KEYNAME_LENGTH) <= 0) {
      EVP_CIPHER_free(aes256cbc);
      ret = SSL_TICKET_FATAL_ERR_OTHER;
      goto end;
    }
    EVP_CIPHER_free(aes256cbc);
    if (SSL_IS_TLS13(s))
      renew_ticket = 1;
  }
  /*
   * Attempt to process session ticket, first conduct sanity and integrity
   * checks on ticket.
   */
  mlen = ssl_hmac_size(hctx);
  if (mlen == 0) {
    ret = SSL_TICKET_FATAL_ERR_OTHER;
    goto end;
  }

  /* Sanity check ticket length: must exceed keyname + IV + HMAC */
  if (eticklen < 48) {
    ret = SSL_TICKET_NO_DECRYPT;
    goto end;
  }
  eticklen -= mlen;
  /* Check HMAC of encrypted ticket */
  if (ssl_hmac_update(hctx, etick, eticklen) <= 0 ||
      ssl_hmac_final(hctx, tick_hmac, NULL, sizeof(tick_hmac)) <= 0) {
    ret = SSL_TICKET_FATAL_ERR_OTHER;
    goto end;
  }

  if (CRYPTO_memcmp(tick_hmac, etick + eticklen, mlen)) {
    ret = SSL_TICKET_NO_DECRYPT;
    goto end;
  }
  /* Attempt to decrypt session data */
  /* Move p after IV to start of encrypted ticket, update length */
  p = etick + TLSEXT_KEYNAME_LENGTH + EVP_CIPHER_CTX_get_iv_length(ctx);
  eticklen -= TLSEXT_KEYNAME_LENGTH + EVP_CIPHER_CTX_get_iv_length(ctx);
  sdec = OPENSSL_malloc(eticklen);
  if (sdec == NULL ||
      EVP_DecryptUpdate(ctx, sdec, &slen, p, (int)eticklen) <= 0) {
    OPENSSL_free(sdec);
    ret = SSL_TICKET_FATAL_ERR_OTHER;
    goto end;
  }
  if (EVP_DecryptFinal(ctx, sdec + slen, &declen) <= 0) {
    OPENSSL_free(sdec);
    ret = SSL_TICKET_NO_DECRYPT;
    goto end;
  }
  slen += declen;
  p = sdec;

  sess = d2i_SSL_SESSION(NULL, &p, slen);
  slen -= p - sdec;
  OPENSSL_free(sdec);
  if (sess) {
    /* Some additional consistency checks */
    if (slen != 0) {
      SSL_SESSION_free(sess);
      sess = NULL;
      ret = SSL_TICKET_NO_DECRYPT;
      goto end;
    }
    /*
     * The session ID, if non-empty, is used by some clients to detect
     * that the ticket has been accepted. So we copy it to the session
     * structure. If it is empty set length to zero as required by
     * standard.
     */
    if (sesslen) {
      memcpy(sess->session_id, sess_id, sesslen);
      sess->session_id_length = sesslen;
    }
    if (renew_ticket)
      ret = SSL_TICKET_SUCCESS_RENEW;
    else
      ret = SSL_TICKET_SUCCESS;
    goto end;
  }
  ERR_clear_error();
  /*
   * For session parse failure, indicate that we need to send a new ticket.
   */
  ret = SSL_TICKET_NO_DECRYPT;

end:
  EVP_CIPHER_CTX_free(ctx);
  ssl_hmac_free(hctx);

  /*
   * If set, the decrypt_ticket_cb() is called unless a fatal error was
   * detected above. The callback is responsible for checking |ret| before it
   * performs any action
   */
  if (s->session_ctx->decrypt_ticket_cb != NULL &&
      (ret == SSL_TICKET_EMPTY || ret == SSL_TICKET_NO_DECRYPT ||
       ret == SSL_TICKET_SUCCESS || ret == SSL_TICKET_SUCCESS_RENEW)) {
    size_t keyname_len = eticklen;
    int retcb;

    if (keyname_len > TLSEXT_KEYNAME_LENGTH)
      keyname_len = TLSEXT_KEYNAME_LENGTH;
    retcb = s->session_ctx->decrypt_ticket_cb(s, sess, etick, keyname_len, ret,
                                              s->session_ctx->ticket_cb_data);
    switch (retcb) {
    case SSL_TICKET_RETURN_ABORT:
      ret = SSL_TICKET_FATAL_ERR_OTHER;
      break;

    case SSL_TICKET_RETURN_IGNORE:
      ret = SSL_TICKET_NONE;
      SSL_SESSION_free(sess);
      sess = NULL;
      break;

    case SSL_TICKET_RETURN_IGNORE_RENEW:
      if (ret != SSL_TICKET_EMPTY && ret != SSL_TICKET_NO_DECRYPT)
        ret = SSL_TICKET_NO_DECRYPT;
      /* else the value of |ret| will already do the right thing */
      SSL_SESSION_free(sess);
      sess = NULL;
      break;

    case SSL_TICKET_RETURN_USE:
    case SSL_TICKET_RETURN_USE_RENEW:
      if (ret != SSL_TICKET_SUCCESS && ret != SSL_TICKET_SUCCESS_RENEW)
        ret = SSL_TICKET_FATAL_ERR_OTHER;
      else if (retcb == SSL_TICKET_RETURN_USE)
        ret = SSL_TICKET_SUCCESS;
      else
        ret = SSL_TICKET_SUCCESS_RENEW;
      break;

    default:
      ret = SSL_TICKET_FATAL_ERR_OTHER;
    }
  }

  if (s->ext.session_secret_cb == NULL || SSL_IS_TLS13(s)) {
    switch (ret) {
    case SSL_TICKET_NO_DECRYPT:
    case SSL_TICKET_SUCCESS_RENEW:
    case SSL_TICKET_EMPTY:
      s->ext.ticket_expected = 1;
    }
  }

  *psess = sess;

  return ret;
}

