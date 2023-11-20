__int64 __fastcall get_long(const char *a1)
{
  char v2[8];
  const char *v3;
  __int64 *v4;
  char *v5;
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
    debug((const char *)debug_info, (char *)qword_4100, (char *)qword_40F8);
    return get_long(v3);
  }
  else if ( !strcmp("localdebug", s) )
  {
    v4 = &savedregs;
    v5 = v2;
    debug("get_long", (char *)&savedregs, v2);
    return get_long(v3);
  }
  else
  {
    return atol(s);
  }
}