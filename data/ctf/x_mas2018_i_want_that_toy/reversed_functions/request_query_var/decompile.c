char *__fastcall request_query_var(const char *a1)
{
  int i;

  for ( i = 0; i < req_cvar; ++i )
  {
    if ( !strcmp(reqvars[i].query, a1) )
      return reqvars[i].param;
  }
  return 0LL;
}