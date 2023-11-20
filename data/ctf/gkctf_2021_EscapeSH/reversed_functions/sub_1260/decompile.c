unsigned __int64 sub_1260()
{
  FILE *v0;
  FILE *v1;
  unsigned int v2;
  unsigned int v3;
  unsigned int v4;
  char *v5;
  int v6;
  unsigned int v7;
  unsigned int v8;
  char v10[1032];
  unsigned __int64 v11;

  v11 = __readfsqword(0x28u);
  v0 = fopen(argv[1], "r");
  if ( v0 )
  {
    v1 = v0;
    v2 = 0;
    v3 = 0;
    v4 = 0;
    while ( fgets(v10, 1024, v1) )
    {
      v5 = v10;
      do
      {
        v6 = *(_DWORD *)v5;
        v5 += 4;
        v7 = ~v6 & (v6 - 16843009) & 0x80808080;
      }
      while ( !v7 );
      if ( (~v6 & (v6 - 16843009) & 0x8080) == 0 )
      {
        LOBYTE(v7) = (~v6 & (v6 - 16843009) & 0x80808080) >> 16;
        LODWORD(v5) = (_DWORD)v5 + 2;
      }
      ++v2;
      v8 = (_DWORD)v5 - (__CFADD__((_BYTE)v7, (_BYTE)v7) + 3) - (unsigned int)v10;
      v3 += v8;
      v10[v8 - 1] = 0;
      if ( strtok(v10, " ") )
      {
        do
          ++v4;
        while ( strtok(0LL, " ") );
      }
    }
    _printf_chk(1LL, "%d\t%d\t%d %s", v2, v4, v3, argv[1]);
    putchar(10);
    fclose(v1);
  }
  else
  {
    puts("open false!");
  }
  return __readfsqword(0x28u) ^ v11;
}