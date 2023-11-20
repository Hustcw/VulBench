__int64 __fastcall get_long(const char *a1)
{
  __int64 v2;
  const char *v3;
  __int64 *v4;
  __int64 *v5;
  char s[40];
  unsigned __int64 v7;
  __int64 savedregs;

  v3 = a1;
  v7 = __readfsqword(0x28u);
  printf("%s> ", a1);
  if ( !fgets(s, 32, stdin) )
    exit(0);
  s[strcspn(s, "\n")] = 0;
  if ( !strcmp("quit", s) )
    exit(0);
  if ( !strcmp("debug", s) )
  {
    debug(debug_info, qword_4100, qword_40F8);
    return get_long(v3);
  }
  else if ( !strcmp("localdebug", s) )
  {
    v4 = &savedregs;
    v5 = &v2;
    debug("get_long", &savedregs, &v2);
    return get_long(v3);
  }
  else
  {
    return atol(s);
  }
}
