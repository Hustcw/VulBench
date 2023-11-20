void __cdecl do_encrypt(workspace_t *ws)
{
  char tmp;
  int k;
  int j;
  int i;

  LOBYTE(i) = 0;
  LOBYTE(j) = 0;
  for ( k = 0; k < ws->buf_len; ++k )
  {
    i = (unsigned __int8)(i + 1);
    j = (unsigned __int8)(*((_BYTE *)ws->_anon_0.print_encoded + i) + j);
    tmp = *((_BYTE *)ws->_anon_0.print_encoded + i);
    *((_BYTE *)ws->_anon_0.print_encoded + i) = *((_BYTE *)ws->_anon_0.print_encoded + j);
    *((_BYTE *)ws->_anon_0.print_encoded + j) = tmp;
    ws->input_buf[k] ^= *((_BYTE *)ws->_anon_0.print_encoded
                        + (unsigned __int8)(*((_BYTE *)ws->_anon_0.print_encoded + i)
                                          + *((_BYTE *)ws->_anon_0.print_encoded + j)));
  }
  puts("Buffer encrypted!");
}
