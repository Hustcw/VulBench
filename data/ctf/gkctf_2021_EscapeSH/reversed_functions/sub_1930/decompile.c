void sub_1930()
{
  int v0;
  char **v1;
  char *v2;
  char v3;

  if ( per_argv_size[0] > 1 )
  {
    v0 = 1;
    v1 = &argv[1];
    do
    {
      v2 = *v1;
      if ( **v1 == 62 )
      {
        v3 = v2[1];
        if ( !v3 || v3 == 62 && !v2[2] )
          break;
      }
      ++v0;
      ++v1;
      _printf_chk(1LL, "%s ", v2);
    }
    while ( per_argv_size[0] > v0 );
  }
  putchar('\n');
}