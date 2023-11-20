void __cdecl do_encrypt(workspace_t *ws)
{
  unsigned __int8 tmp;
  int k;
  int j;
  int i;

  LOBYTE(i) = 0;
  LOBYTE(j) = 0;
  for ( k = 0; k < ws->buf_len; ++k )
  {
    i = (unsigned __int8)(i + 1);
    j = (unsigned __int8)(ws->_anon_0.enc_state[i] + j);
    tmp = ws->_anon_0.enc_state[i];
    ws->_anon_0.enc_state[i] = ws->_anon_0.enc_state[j];
    ws->_anon_0.enc_state[j] = tmp;
    ws->input_buf[k] ^= ws->_anon_0.enc_state[(unsigned __int8)(ws->_anon_0.enc_state[i] + ws->_anon_0.enc_state[j])];
  }
  puts("Buffer encrypted!");
}