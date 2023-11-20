char *__fastcall request_query_var(const char *a1)
{
  int i;

  for ( i = 0; i < req_cvar; ++i )
  {
    if ( !strcmp(&reqvars[96 * i], a1) )
      return &reqvars[96 * i + 32];
  }
  return 0LL;
}
