void sub_1EC0()
{
  int v0;
  int v1;
  char **i;
  int v3;
  char *v4;
  char v5;
  char *v6;
  int v7;
  char *v8;
  char v9;
  int v10;
  int v11;
  int v12;
  char v13[776];
  unsigned __int64 v14;

  v14 = __readfsqword(0x28u);
  v0 = per_argv_size[0];
  if ( per_argv_size[0] <= 1 )
    return;
  v1 = 2;
  for ( i = &argv[1]; ; ++i )
  {
    while ( 1 )
    {
      v4 = *i;
      if ( **i == '>' )
      {
        v5 = v4[1];
        if ( !v5 )
        {
          v6 = i[1];
          v7 = v1;
          if ( !v6 )
            goto LABEL_26;
          goto LABEL_7;
        }
        if ( v5 == '>' && !v4[2] )
          break;
      }
      v3 = v1;
      ++i;
      ++v1;
      if ( v0 <= v3 )
        return;
    }
    v6 = i[1];
    v7 = v1;
    if ( !v6 )
    {
LABEL_26:
      puts("> or >> no file");
      goto LABEL_8;
    }
LABEL_7:
    _strcpy_chk(v13, v6, 768LL);
    _printf_chk(1LL, "dest_filename = %s", v13);
LABEL_8:
    v8 = *i;
    if ( **i == 62 )
    {
      v9 = v8[1];
      if ( v9 )
        goto LABEL_15;
      v10 = open(v13, 0x241, 0x1B6LL);
      if ( v10 < 0 )
        goto LABEL_27;
      do
        v11 = fork();
      while ( v11 < 0 );
      if ( !v11 )
        goto LABEL_28;
      waitpid(v11, 0LL, 0);
      v8 = *i;
      if ( **i == 62 )
        break;
    }
LABEL_21:
    v0 = per_argv_size[0];
    ++v1;
    if ( per_argv_size[0] <= v7 )
      return;
  }
  v9 = v8[1];
LABEL_15:
  if ( v9 != 62 || v8[2] )
    goto LABEL_21;
  v10 = open(v13, 1089, 438LL);
  if ( v10 < 0 )
  {
LABEL_27:
    puts("open or no this file false!");
    return;
  }
  do
    v12 = fork();
  while ( v12 < 0 );
  if ( v12 )
  {
    waitpid(v12, 0LL, 0);
    goto LABEL_21;
  }
LABEL_28:
  if ( dup2(v10, 1) >= 0 )
  {
    sub_1930();
    exit(0);
  }
  puts("err in dup2");
}