unsigned __int64 sub_15A0()
{
  int v0;
  char *v1;
  int i;
  char *v4;
  char v5;
  struct utsname v6;
  __int64 v7;
  __int16 v8;
  char v9[160];
  char buf[776];
  unsigned __int64 v11;

  v11 = __readfsqword(0x28u);
  v7 = 0x7265646E3457LL;
  v8 = 0;
  if ( uname(&v6) )
  {
    perror("uname");
    exit(1);
  }
  if ( !getcwd(buf, 0x300uLL) )
  {
    puts("get path_name error");
    exit(-1);
  }
  memset(v9, 0, 153);
  v0 = strlen(buf);
  if ( strcmp(buf, path) )
  {
    for ( i = v0; buf[i] != 47; --i )
      ;
    v4 = v9;
    v5 = 47;
    do
    {
      ++i;
      *v4++ = v5;
      v5 = buf[i];
    }
    while ( v5 );
  }
  v1 = getcwd(buf, 0x300uLL);
  if ( strstr(v1, path) )
    _printf_chk(1LL, "\x1B[1;3;31m%s@%s\x1B[m:\x1B[34m~%s\x1B[m$ ", (const char *)&v7, v6.nodename, v9);
  else
    _printf_chk(1LL, "\x1B[1;3;31m%s@%s\x1B[m:\x1B[34m%s\x1B[m$ ", (const char *)&v7, v6.nodename, buf);
  return __readfsqword(0x28u) ^ v11;
}
