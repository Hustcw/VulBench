int __cdecl __noreturn main(int argc, const char **argv, const char **envp)
{
  unsigned int v3;
  __int64 v4;
  unsigned __int64 v5;
  unsigned __int8 *v6;
  ssize_t v7;
  _BYTE *v8;
  unsigned __int64 v9;
  unsigned __int8 *v10;
  int v11;
  char *v12;
  void *v13;

  setvbuf(stdout, 0LL, 2, 0LL);
  setvbuf(stderr, 0LL, 2, 0LL);
  fp = (__int64)malloc(8uLL);
  if ( !fp )
    err(1, "uhhh?");
  if ( getenv("DEBUG") )
    *(_QWORD *)fp = debug_end_of_entry;
  else
    *(_QWORD *)fp = end_of_entry;
  display_banner();
  v3 = 0;
  print_menu(0LL);
  v4 = line_4718;
  if ( !line_4718 )
    goto LABEL_14;
  while ( 1 )
  {
    do
    {
      v5 = 0LL;
      v6 = (unsigned __int8 *)v4;
      while ( 1 )
      {
        v7 = read(0, v6, 2048 - v5);
        if ( !v7 )
          err(1, "remote end disappeared");
        v8 = (_BYTE *)(line_4718 + v5);
        if ( *(_BYTE *)(line_4718 + v5) == 10 )
          break;
        v9 = v5 + 1;
        v5 += v7;
        v10 = (unsigned __int8 *)(line_4718 + v9);
        v6 = (unsigned __int8 *)(line_4718 + v5);
        while ( v10 != v6 )
        {
          v8 = v10;
          v11 = *v10++;
          if ( v11 == 10 )
            goto LABEL_13;
        }
        if ( v5 > 0x7FF )
          err(1, "expected newline in < %d bytes\n", 2048LL);
      }
LABEL_13:
      v12 = (char *)line_4718;
      *v8 = 0;
      v3 = parse_line(v3, v12);
      print_menu(v3);
      v4 = line_4718;
    }
    while ( line_4718 );
LABEL_14:
    v13 = malloc(0x800uLL);
    line_4718 = (__int64)v13;
    if ( !v13 )
      err(1, "malloc");
    v4 = (__int64)v13;
  }
}
