void __cdecl set_input(workspace_t *ws)
{
  size_t v1;
  const char *inp;

  if ( ws->input_buf )
  {
    secure_free(ws->input_buf);
    ws->input_buf = 0LL;
    ws->buf_len = 0LL;
  }
  inp = prompt("input");
  if ( inp )
  {
    ws->input_buf = secure_strdup(inp);
    v1 = strlen(ws->input_buf);
    printf("Input is %lu bytes long.\n", v1);
    ws->buf_len = strlen(ws->input_buf);
  }
  else
  {
    printf("No input!");
  }
}
