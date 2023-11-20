int __fastcall tls_parse_ctos_status_request(SSL_3 *s, PACKET *pkt, unsigned int context, X509 *x, size_t chainidx)
{
  int v5;
  PACKET *v6;
  int *p_status_type;
  OPENSSL_STACK *v8;
  OPENSSL_STACK *v9;
  int v10;
  int v11;
  int v12;
  PACKET *p_responder_id_list;
  PACKET *p_responder_id;
  int v16;
  OCSP_RESPID *v17;
  const PACKET *v18;
  OCSP_RESPID *v19;
  const PACKET *v20;
  const unsigned __int8 *v21;
  SSL_3 *v22;
  OPENSSL_STACK *v23;
  OCSP_RESPID *v24;
  size_t v25;
  SSL_3 *v26;
  OPENSSL_STACK *v27;
  int v28;
  X509_EXTENSIONS *v29;
  const unsigned __int8 *v30;
  int v31;
  PACKET responder_id_list;
  PACKET *pkta;
  PACKET responder_id;
  const unsigned __int8 *ext_data;
  SSL_3 *sa;

  v5 = 1;
  if ( !x && !s->hit )
  {
    v6 = pkt;
    p_status_type = &s->ext.status_type;
    if ( PACKET_get_1_4(pkt, (unsigned int *)&s->ext.status_type) )
    {
      if ( *p_status_type != 1 )
      {
        *p_status_type = -1;
        return 1;
      }
      if ( PACKET_get_length_prefixed_2_1(pkt, &responder_id_list) )
      {
        v8 = ossl_check_OCSP_RESPID_sk_type_0(s->ext.ocsp.ids);
        OPENSSL_sk_pop_free(v8, (OPENSSL_sk_freefunc)OCSP_RESPID_free);
        if ( PACKET_remaining_7(&responder_id_list) )
        {
          v9 = OPENSSL_sk_new_null();
          s->ext.ocsp.ids = (stack_st_OCSP_RESPID *)v9;
          if ( !v9 )
          {
            ERR_new();
            ERR_set_debug("ssl/statem/extensions_srvr.c", 341, "tls_parse_ctos_status_request");
            v5 = 0;
            v10 = 80;
            v11 = 786688;
LABEL_15:
            ossl_statem_fatal(s, v10, v11, 0LL);
            return v5;
          }
        }
        else
        {
          s->ext.ocsp.ids = 0LL;
        }
        sa = s;
        if ( PACKET_remaining_7(&responder_id_list) )
        {
          p_responder_id_list = &responder_id_list;
          p_responder_id = &responder_id;
          pkta = pkt;
          while ( 1 )
          {
            if ( !PACKET_get_length_prefixed_2_1(p_responder_id_list, p_responder_id)
              || !PACKET_remaining_7(p_responder_id) )
            {
              ERR_new();
              v31 = 372;
              goto LABEL_35;
            }
            ext_data = PACKET_data_4(p_responder_id);
            v16 = PACKET_remaining_7(p_responder_id);
            v17 = d2i_OCSP_RESPID(0LL, &ext_data, v16);
            if ( !v17 )
            {
              ERR_new();
              v31 = 380;
              goto LABEL_35;
            }
            v18 = p_responder_id;
            v19 = v17;
            v20 = p_responder_id_list;
            v21 = ext_data;
            if ( v21 != PACKET_end(v18) )
            {
              OCSP_RESPID_free(v19);
              ERR_new();
              v31 = 386;
              goto LABEL_35;
            }
            v22 = sa;
            v23 = ossl_check_OCSP_RESPID_sk_type_0(sa->ext.ocsp.ids);
            v24 = ossl_check_OCSP_RESPID_type(v19);
            if ( !OPENSSL_sk_push(v23, v24) )
              break;
            p_responder_id_list = (PACKET *)v20;
            v25 = PACKET_remaining_7(v20);
            v5 = 1;
            p_responder_id = (PACKET *)v18;
            v6 = pkta;
            if ( !v25 )
              goto LABEL_26;
          }
          OCSP_RESPID_free(v19);
          ERR_new();
          ERR_set_debug("ssl/statem/extensions_srvr.c", 393, "tls_parse_ctos_status_request");
          v5 = 0;
          s = v22;
          v10 = 80;
          v11 = 786691;
          goto LABEL_15;
        }
LABEL_26:
        if ( !PACKET_as_length_prefixed_2_0(v6, &responder_id) )
        {
          ERR_new();
          v31 = 401;
LABEL_35:
          ERR_set_debug("ssl/statem/extensions_srvr.c", v31, "tls_parse_ctos_status_request");
          v5 = 0;
          s = sa;
          goto LABEL_14;
        }
        if ( !PACKET_remaining_7(&responder_id) )
          return v5;
        ext_data = PACKET_data_4(&responder_id);
        v26 = sa;
        v27 = ossl_check_X509_EXTENSION_sk_type_0((stack_st_X509_EXTENSION *)sa->ext.ocsp.exts);
        OPENSSL_sk_pop_free(v27, (OPENSSL_sk_freefunc)X509_EXTENSION_free);
        v28 = PACKET_remaining_7(&responder_id);
        v5 = 0;
        v29 = d2i_X509_EXTENSIONS(0LL, &ext_data, v28);
        v26->ext.ocsp.exts = v29;
        if ( !v29 || (v30 = ext_data, v30 != PACKET_end(&responder_id)) )
        {
          ERR_new();
          ERR_set_debug("ssl/statem/extensions_srvr.c", 413, "tls_parse_ctos_status_request");
          s = v26;
          goto LABEL_14;
        }
        return 1;
      }
      ERR_new();
      v12 = 328;
    }
    else
    {
      ERR_new();
      v12 = 315;
    }
    ERR_set_debug("ssl/statem/extensions_srvr.c", v12, "tls_parse_ctos_status_request");
    v5 = 0;
LABEL_14:
    v10 = 50;
    v11 = 110;
    goto LABEL_15;
  }
  return v5;
}
