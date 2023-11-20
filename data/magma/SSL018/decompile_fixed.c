int __fastcall dtls1_preprocess_fragment(SSL_3 *s, hm_header_st *msg_hdr)
{
  size_t msg_len;
  int v3;
  int v4;
  int v5;
  int v6;
  dtls1_state_st *d1;
  dtls1_state_st *v9;
  int type;

  msg_len = msg_hdr->msg_len;
  if ( msg_hdr->frag_off + msg_hdr->frag_len <= msg_len && msg_len <= dtls1_max_handshake_message_len(s) )
  {
    d1 = s->d1;
    if ( !d1->r_msg_hdr.frag_off )
    {
      if ( BUF_MEM_grow_clean(s->init_buf, msg_len + 12) )
      {
        s->s3.tmp.message_size = msg_len;
        v9 = s->d1;
        v9->r_msg_hdr.msg_len = msg_len;
        type = msg_hdr->type;
        s->s3.tmp.message_type = type;
        v9->r_msg_hdr.type = type;
        v9->r_msg_hdr.seq = msg_hdr->seq;
        return 1;
      }
      ERR_new();
      ERR_set_debug("ssl/statem/statem_dtls.c", 467, "dtls1_preprocess_fragment");
      v4 = 0;
      v5 = 80;
      v6 = 524295;
      goto LABEL_5;
    }
    v4 = 1;
    if ( msg_len == d1->r_msg_hdr.msg_len )
      return v4;
    ERR_new();
    v3 = 481;
  }
  else
  {
    ERR_new();
    v3 = 454;
  }
  ERR_set_debug("ssl/statem/statem_dtls.c", v3, "dtls1_preprocess_fragment");
  v4 = 0;
  v5 = 47;
  v6 = 152;
LABEL_5:
  ossl_statem_fatal(s, v5, v6, 0LL);
  return v4;
}


size_t __fastcall dtls1_max_handshake_message_len(const SSL_3 *s)
{
  size_t result;

  result = 17740LL;
  if ( s->max_cert_list > 0x454C )
    return s->max_cert_list;
  return result;
}
