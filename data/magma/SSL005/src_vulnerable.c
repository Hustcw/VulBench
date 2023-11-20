int tls_parse_ctos_status_request(SSL *s, PACKET *pkt, unsigned int context,
                                  X509 *x, size_t chainidx) {
  PACKET responder_id_list, exts;

  /* We ignore this in a resumption handshake */
  if (s->hit)
    return 1;

  /* Not defined if we get one of these in a client Certificate */
  if (x != NULL)
    return 1;

  if (!PACKET_get_1(pkt, (unsigned int *)&s->ext.status_type)) {
    SSLfatal(s, SSL_AD_DECODE_ERROR, SSL_R_BAD_EXTENSION);
    return 0;
  }

  if (s->ext.status_type != TLSEXT_STATUSTYPE_ocsp) {
    /*
     * We don't know what to do with any other type so ignore it.
     */
    s->ext.status_type = TLSEXT_STATUSTYPE_nothing;
    return 1;
  }

  if (!PACKET_get_length_prefixed_2(pkt, &responder_id_list)) {
    SSLfatal(s, SSL_AD_DECODE_ERROR, SSL_R_BAD_EXTENSION);
    return 0;
  }

  if (PACKET_remaining(&responder_id_list) > 0 && s->ext.ocsp.ids == NULL) {
    s->ext.ocsp.ids = sk_OCSP_RESPID_new_null();
    if (s->ext.ocsp.ids == NULL) {
      SSLfatal(s, SSL_AD_INTERNAL_ERROR, ERR_R_MALLOC_FAILURE);
      return 0;
    }
  }

  while (PACKET_remaining(&responder_id_list) > 0) {
    OCSP_RESPID *id;
    PACKET responder_id;
    const unsigned char *id_data;

    if (!PACKET_get_length_prefixed_2(&responder_id_list, &responder_id) ||
        PACKET_remaining(&responder_id) == 0) {
      SSLfatal(s, SSL_AD_DECODE_ERROR, SSL_R_BAD_EXTENSION);
      return 0;
    }

    id_data = PACKET_data(&responder_id);
    id = d2i_OCSP_RESPID(NULL, &id_data, (int)PACKET_remaining(&responder_id));
    if (id == NULL) {
      SSLfatal(s, SSL_AD_DECODE_ERROR, SSL_R_BAD_EXTENSION);
      return 0;
    }

    if (id_data != PACKET_end(&responder_id)) {
      OCSP_RESPID_free(id);
      SSLfatal(s, SSL_AD_DECODE_ERROR, SSL_R_BAD_EXTENSION);

      return 0;
    }

    if (!sk_OCSP_RESPID_push(s->ext.ocsp.ids, id)) {
      OCSP_RESPID_free(id);
      SSLfatal(s, SSL_AD_INTERNAL_ERROR, ERR_R_INTERNAL_ERROR);

      return 0;
    }
  }

  /* Read in request_extensions */
  if (!PACKET_as_length_prefixed_2(pkt, &exts)) {
    SSLfatal(s, SSL_AD_DECODE_ERROR, SSL_R_BAD_EXTENSION);
    return 0;
  }

  if (PACKET_remaining(&exts) > 0) {
    const unsigned char *ext_data = PACKET_data(&exts);

    sk_X509_EXTENSION_pop_free(s->ext.ocsp.exts, X509_EXTENSION_free);
    s->ext.ocsp.exts =
        d2i_X509_EXTENSIONS(NULL, &ext_data, (int)PACKET_remaining(&exts));
    if (s->ext.ocsp.exts == NULL || ext_data != PACKET_end(&exts)) {
      SSLfatal(s, SSL_AD_DECODE_ERROR, SSL_R_BAD_EXTENSION);
      return 0;
    }
  }

  return 1;
}

