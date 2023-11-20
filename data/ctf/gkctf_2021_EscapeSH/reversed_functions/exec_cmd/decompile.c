void exec_cmd()
{
  int v0;
  bool v1;
  const char *v2;
  __int64 v3;
  char **v4;
  bool v5;
  char **v6;
  char *v7;
  char v8;
  const char *v9;
  __int64 v10;
  char *v11;
  bool v12;
  const char *v13;
  __int64 v14;
  char *v15;
  bool v16;
  const char *v17;
  __int64 v18;
  char *v19;
  __int64 v20;

  if ( !argv[0] )
    return;
  v0 = (unsigned __int8)*argv[0];
  v1 = v0 == 'p';
  if ( v0 == 'p' )
  {
    if ( argv[0][1] == 'w' && argv[0][2] == 'd' && !argv[0][3] )
    {
      sub_18C0();
      return;
    }
    v5 = strcmp(argv[0], "echo") == 0;
    if ( v5 )
      goto LABEL_16;
    goto LABEL_24;
  }
  v2 = "echo";
  v3 = 5LL;
  v4 = (char **)argv[0];
  do
  {
    if ( !v3 )
      break;
    v1 = *(_BYTE *)v4 == *v2;
    v4 = (char **)((char *)v4 + 1);
    ++v2;
    --v3;
  }
  while ( v1 );
  if ( !v1 )
  {
    if ( v0 == 'l' )
    {
      v5 = argv[0][1] == 's';
      if ( argv[0][1] == 's' )
      {
        v5 = argv[0][2] == 0;
        if ( !argv[0][2] )
        {
          cmd_ls();
          return;
        }
      }
    }
    else
    {
      v5 = v0 == 99;
      if ( v0 == 99 )
      {
        v12 = argv[0][1] == 100;
        if ( argv[0][1] == 100 )
        {
          v12 = argv[0][2] == 0;
          if ( !argv[0][2] )
          {
            sub_1B90(v2, v4);
            return;
          }
        }
        v9 = "mkdir";
        v20 = 6LL;
        v11 = argv[0];
        do
        {
          if ( !v20 )
            break;
          v12 = *v11++ == *v9++;
          --v20;
        }
        while ( v12 );
        if ( !v12 )
          goto LABEL_30;
        goto LABEL_54;
      }
    }
LABEL_24:
    v9 = "mkdir";
    v10 = 6LL;
    v11 = argv[0];
    do
    {
      if ( !v10 )
        break;
      v5 = *v11++ == *v9++;
      --v10;
    }
    while ( v5 );
    if ( !v5 )
    {
      v12 = v0 == 119;
      if ( v0 == 119 )
      {
        v12 = argv[0][1] == 99;
        if ( argv[0][1] == 99 )
        {
          v12 = argv[0][2] == 0;
          if ( !argv[0][2] )
          {
            sub_1D60(v9, v11);
            return;
          }
        }
      }
LABEL_30:
      v13 = "clear";
      v14 = 6LL;
      v15 = argv[0];
      do
      {
        if ( !v14 )
          break;
        v12 = *v15++ == *v13++;
        --v14;
      }
      while ( v12 );
      if ( v12 )
      {
        sub_1DA0(v13, v15);
      }
      else
      {
        v16 = strcmp(argv[0], "help") == 0;
        if ( v16 )
        {
          menu();
        }
        else
        {
          v17 = "monitor";
          v18 = 8LL;
          v19 = argv[0];
          do
          {
            if ( !v18 )
              break;
            v16 = *v19++ == *v17++;
            --v18;
          }
          while ( v16 );
          if ( v16 )
          {
            sub_1410(v17, v19);
          }
          else
          {
            if ( !strcmp(argv[0], "quit") )
              quit();
            puts("No has this command!");
          }
        }
      }
      return;
    }
LABEL_54:
    sub_1D10(v9, v11);
    return;
  }
LABEL_16:
  if ( per_argv_size[0] <= 1 )
  {
LABEL_41:
    sub_1930();
  }
  else
  {
    v6 = &argv[1];
    while ( 1 )
    {
      v7 = *v6;
      if ( **v6 == '>' )
      {
        v8 = v7[1];
        if ( !v8 || v8 == '>' && !v7[2] )
          break;
      }
      if ( &argv[(unsigned int)(per_argv_size[0] - 2) + 2] == ++v6 )
        goto LABEL_41;
    }
    sub_1EC0();
  }
}