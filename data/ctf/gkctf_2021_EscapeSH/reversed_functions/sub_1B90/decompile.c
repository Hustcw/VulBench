unsigned __int64 sub_1B90()
{
  const char *v0;
  int v1;
  char *v3;
  char v4;
  _BYTE *v5;
  int v6;
  __int64 v7;
  char v8;
  char buf;
  _BYTE v10[7];
  unsigned __int64 v11;

  v11 = __readfsqword(0x28u);
  v8 = 47;
  v0 = argv[1];
  if ( !v0 )
  {
    chdir(path);
    return __readfsqword(0x28u) ^ v11;
  }
  v1 = chdir(v0);
  if ( v1 == -1 )
  {
    if ( !getcwd(&buf, 0x300uLL) )
    {
      puts("cd error");
      exit(v1);
    }
    v3 = argv[1];
    if ( *v3 == 46 )
    {
      v4 = v3[1];
      if ( v4 == 46 )
      {
        if ( !v3[2] )
        {
          if ( buf )
          {
            v5 = v10;
            v6 = 0;
            do
            {
              ++v5;
              ++v6;
            }
            while ( *(v5 - 1) );
          }
          else
          {
            v6 = 0;
          }
          v7 = v6;
          do
          {
            --v6;
            v10[v7 - 1] = 0;
            v7 = v6;
          }
          while ( v10[v6 - 1] != 47 );
          goto LABEL_7;
        }
      }
      else if ( !v4 )
      {
        putchar(10);
LABEL_7:
        if ( chdir(&buf) == -1 )
          puts("cd no dir");
        return __readfsqword(0x28u) ^ v11;
      }
    }
    _strncat_chk(&buf, &v8, 1LL, 768LL);
    _strncat_chk(&buf, v3, 1000LL, 768LL);
    goto LABEL_7;
  }
  return __readfsqword(0x28u) ^ v11;
}