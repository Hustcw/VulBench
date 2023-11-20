void *__fastcall request_header(const char *a1)
{
  void **i;

  for ( i = &reqhdr; *i; i += 2 )
  {
    if ( !strcmp((const char *)*i, a1) )
      return i[1];
  }
  return 0LL;
}
