int __cdecl __noreturn main(int argc, const char **argv, const char **envp)
{
  unsigned int v3;
  char *v4;
  unsigned __int64 v5;
  char *v6;
  ssize_t v7;
  char *v8;
  unsigned __int64 v9;
  char *v10;
  int v11;
  char *v12;
  char *v13;

  setvbuf(stdout, 0LL, 2, 0LL);
  setvbuf(stderr, 0LL, 2, 0LL);
  fp = (Entry *(__fastcall **)(Entry *))malloc(8uLL);
  if ( !fp )
    err(1, "uhhh?");
  if ( getenv("DEBUG") )
    *fp = debug_end_of_entry;
  else
    *fp = end_of_entry;
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
      v6 = v4;
      while ( 1 )
      {
        v7 = read(0, v6, 2048 - v5);
        if ( !v7 )
          err(1, "remote end disappeared");
        v8 = &line_4718[v5];
        if ( line_4718[v5] == '\n' )
          break;
        v9 = v5 + 1;
        v5 += v7;
        v10 = &line_4718[v9];
        v6 = &line_4718[v5];
        while ( v10 != v6 )
        {
          v8 = v10;
          v11 = (unsigned __int8)*v10++;
          if ( v11 == 10 )
            goto LABEL_13;
        }
        if ( v5 > 0x7FF )
          err(1, "expected newline in < %d bytes\n", 2048LL);
      }
LABEL_13:
      v12 = line_4718;
      *v8 = 0;
      v3 = parse_line(v3, v12);
      print_menu(v3);
      v4 = line_4718;
    }
    while ( line_4718 );
LABEL_14:
    v13 = (char *)malloc(0x800uLL);
    line_4718 = v13;
    if ( !v13 )
      err(1, "malloc");
    v4 = v13;
  }
}