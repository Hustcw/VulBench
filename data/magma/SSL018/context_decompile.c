size_t __fastcall dtls1_max_handshake_message_len(const SSL_3 *s)
{
  size_t result;

  result = 17740LL;
  if ( s->max_cert_list > 0x454C )
    return s->max_cert_list;
  return result;
}
