void get_path()
{
  int v0;
  char *v1;
  int i;
  char *v3;
  char v4;
  struct utsname v5;
  __int64 v6;
  __int16 v7;
  char v8[160];
  char buf[776];
  unsigned __int64 v10;

  v10 = __readfsqword(0x28u);
  v6 = 0x7265646E3457LL;
  v7 = 0;
  if ( uname(&v5) )
  {
    perror("uname");
    exit(1);
  }
  if ( !getcwd(buf, 0x300uLL) )
  {
    puts("get path_name error");
    exit(-1);
  }
  memset(v8, 0, 153);
  v0 = strlen(buf);
  if ( strcmp(buf, path) )
  {
    for ( i = v0; buf[i] != 47; --i )
      ;
    v3 = v8;
    v4 = 47;
    do
    {
      ++i;
      *v3++ = v4;
      v4 = buf[i];
    }
    while ( v4 );
  }
  v1 = getcwd(buf, 0x300uLL);
  if ( strstr(v1, path) )
    _printf_chk(1LL, "\x1B[1;3;31m%s@%s\x1B[m:\x1B[34m~%s\x1B[m$ ", (const char *)&v6, v5.nodename, v8);
  else
    _printf_chk(1LL, "\x1B[1;3;31m%s@%s\x1B[m:\x1B[34m%s\x1B[m$ ", (const char *)&v6, v5.nodename, buf);
}