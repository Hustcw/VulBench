__int64 debug_info;
__int64 qword_40F8;
__int64 qword_4100;

int __cdecl main(int argc, const char **argv, const char **envp)
{
  const char **v4;
  int v5;
  __int64 v6;
  __int64 v7;
  _QWORD v8[128];
  __int64 savedregs;

  v5 = argc;
  v4 = argv;
  qword_4100 = (__int64)&savedregs;
  qword_40F8 = (__int64)&v4;
  debug_info = (__int64)"main";
  v6 = get_long("Number of numbers to add");
  if ( v6 <= 127 )
  {
    get_data(v8, v6);
    v7 = add_nums((__int64)v8, v6);
    printf("Total is %ld\n", v7);
    return 0;
  }
  else
  {
    printf("Error, can only handle up to %d (CHAR_MAX) values!\n", 127LL);
    return 1;
  }
}

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

unsigned __int64 __fastcall get_data(__int64 *a1, unsigned __int8 a2)
{
  int i;
  char s[40];
  unsigned __int64 v6;

  v6 = __readfsqword(0x28u);
  for ( i = 0; i < a2; ++i )
  {
    snprintf(s, 0x20uLL, "long %d", (unsigned int)i);
    *a1++ = get_long(s);
  }
  return __readfsqword(0x28u) ^ v6;
}

__int64 __fastcall add_nums(__int64 a1, unsigned __int8 a2)
{
  int i;
  __int64 v4;

  v4 = 0LL;
  for ( i = 0; i < a2; ++i )
    v4 += *(_QWORD *)(8LL * i + a1);
  return v4;
}

unsigned __int64 __fastcall debug(const char *a1, char *a2, char *a3)
{
  char *i;
  unsigned __int64 v6;

  v6 = __readfsqword(0x28u);
  printf("Debug in %s\n", a1);
  printf("  main @ %p\n", main);
  printf("  printf @ %p\n", &printf);
  printf("  malloc @ %p\n", &malloc);
  putchar(10);
  printf("RSP is %p, RBP is %p\n", a3, a2);
  putchar(10);
  for ( i = a3; i <= a2; i += 16 )
    hexdump_line(i);
  return __readfsqword(0x28u) ^ v6;
}

unsigned __int64 __fastcall hexdump_line(_BYTE *a1)
{
  char v2;
  int i;
  int j;
  unsigned __int64 v5;

  v5 = __readfsqword(0x28u);
  printf("%p | ", a1);
  for ( i = 0; i <= 15; ++i )
  {
    printf("%02x ", (unsigned __int8)a1[i]);
    if ( i == 7 )
      putchar(' ');
  }
  putchar(124);
  for ( j = 0; j <= 15; ++j )
  {
    v2 = a1[j];
    if ( v2 <= 0x1F || v2 == 0x7F )
      putchar('.');
    else
      putchar(v2);
  }
  puts("|");
  return __readfsqword(0x28u) ^ v5;
}