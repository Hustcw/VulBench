int __fastcall tls_parse_ctos_status_request(SSL_3 *s, PACKET *pkt, unsigned int context, X509 *x, size_t chainidx)
{
  int v5;
  SSL_3 *v6;
  int *p_status_type;
  OPENSSL_STACK *v8;
  int v9;
  OCSP_RESPID *v10;
  OCSP_RESPID *v11;
  const unsigned __int8 *v12;
  OPENSSL_STACK *v13;
  OCSP_RESPID *v14;
  OPENSSL_STACK *v15;
  int v16;
  X509_EXTENSIONS *v17;
  const unsigned __int8 *v18;
  int v19;
  int v20;
  int v21;
  int v23;
  PACKET responder_id_list;
  PACKET responder_id;
  const unsigned __int8 *ext_data;
  SSL_3 *sa;

  v5 = 1;
  if ( !x )
  {
    v6 = s;
    if ( !s->hit )
    {
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
          if ( PACKET_remaining_7(&responder_id_list) )
          {
            if ( !s->ext.ocsp.ids )
            {
              v8 = OPENSSL_sk_new_null();
              s->ext.ocsp.ids = (stack_st_OCSP_RESPID *)v8;
              if ( !v8 )
              {
                ERR_new();
                ERR_set_debug("ssl/statem/extensions_srvr.c", 351, "tls_parse_ctos_status_request");
                v5 = 0;
                v20 = 80;
                v21 = 786688;
                goto LABEL_28;
              }
            }
          }
          sa = s;
          if ( PACKET_remaining_7(&responder_id_list) )
          {
            while ( 1 )
            {
              if ( !PACKET_get_length_prefixed_2_1(&responder_id_list, &responder_id)
                || !PACKET_remaining_7(&responder_id) )
              {
                ERR_new();
                v23 = 372;
                goto LABEL_35;
              }
              ext_data = PACKET_data_4(&responder_id);
              v9 = PACKET_remaining_7(&responder_id);
              v10 = d2i_OCSP_RESPID(0LL, &ext_data, v9);
              if ( !v10 )
              {
                ERR_new();
                v23 = 380;
                goto LABEL_35;
              }
              v11 = v10;
              v12 = ext_data;
              if ( v12 != PACKET_end(&responder_id) )
              {
                OCSP_RESPID_free(v11);
                ERR_new();
                v23 = 386;
                goto LABEL_35;
              }
              v13 = ossl_check_OCSP_RESPID_sk_type_0(sa->ext.ocsp.ids);
              v14 = ossl_check_OCSP_RESPID_type(v11);
              if ( !OPENSSL_sk_push(v13, v14) )
                break;
              if ( !PACKET_remaining_7(&responder_id_list) )
                goto LABEL_16;
            }
            OCSP_RESPID_free(v11);
            ERR_new();
            ERR_set_debug("ssl/statem/extensions_srvr.c", 393, "tls_parse_ctos_status_request");
            v5 = 0;
            s = sa;
            v20 = 80;
            v21 = 786691;
            goto LABEL_28;
          }
LABEL_16:
          if ( !PACKET_as_length_prefixed_2_0(pkt, &responder_id) )
          {
            ERR_new();
            v23 = 401;
LABEL_35:
            ERR_set_debug("ssl/statem/extensions_srvr.c", v23, "tls_parse_ctos_status_request");
            v5 = 0;
            s = sa;
            goto LABEL_27;
          }
          if ( PACKET_remaining_7(&responder_id) )
          {
            ext_data = PACKET_data_4(&responder_id);
            v6 = sa;
            v15 = ossl_check_X509_EXTENSION_sk_type_0((stack_st_X509_EXTENSION *)sa->ext.ocsp.exts);
            OPENSSL_sk_pop_free(v15, (OPENSSL_sk_freefunc)X509_EXTENSION_free);
            v16 = PACKET_remaining_7(&responder_id);
            v5 = 0;
            v17 = d2i_X509_EXTENSIONS(0LL, &ext_data, v16);
            v6->ext.ocsp.exts = v17;
            if ( !v17 || (v18 = ext_data, v18 != PACKET_end(&responder_id)) )
            {
              ERR_new();
              ERR_set_debug("ssl/statem/extensions_srvr.c", 413, "tls_parse_ctos_status_request");
LABEL_26:
              s = v6;
LABEL_27:
              v20 = 50;
              v21 = 110;
LABEL_28:
              ossl_statem_fatal(s, v20, v21, 0LL);
              return v5;
            }
          }
          return 1;
        }
        ERR_new();
        v19 = 328;
      }
      else
      {
        ERR_new();
        v19 = 315;
      }
      ERR_set_debug("ssl/statem/extensions_srvr.c", v19, "tls_parse_ctos_status_request");
      v5 = 0;
      goto LABEL_26;
    }
  }
  return v5;
}
