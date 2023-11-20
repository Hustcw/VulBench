void __cdecl set_encoding(workspace_t *ws)
{
  const char *enc;

  enc = prompt("encoding (base64, hex)");
  if ( !strcasecmp("base64", enc) )
  {
    ws->_anon_0.print_encoded = (void (*)(const char *, size_t))print_base64;
  }
  else if ( !strcasecmp("hex", enc) )
  {
    ws->_anon_0.print_encoded = (void (*)(const char *, size_t))print_hex;
  }
  else
  {
    puts("Invalid encoding!");
  }
}
