void __cdecl print_state(workspace_t *ws)
{
  if ( (ws->type & 2) != 0 )
  {
    if ( ws->_anon_0.print_encoded )
      ws->_anon_0.print_encoded(ws->input_buf, ws->buf_len);
    else
      puts("Must use set_encoding first.");
  }
  else if ( (ws->type & 1) != 0 )
  {
    puts(ws->input_buf);
  }
  else
  {
    puts("Printing not supported for encrypted data.");
  }
}
