unsigned __int64 sub_1EC0()
{
  int v0;
  int v1;
  _QWORD *i;
  int v3;
  _BYTE *v4;
  char v5;
  __int64 v6;
  int v7;
  _BYTE *v8;
  char v9;
  int v10;
  int v11;
  int v12;
  char v14[776];
  unsigned __int64 v15;

  v15 = __readfsqword(0x28u);
  v0 = unk_205B40;
  if ( unk_205B40 <= 1 )
    return __readfsqword(0x28u) ^ v15;
  v1 = 2;
  for ( i = &qword_204040[1]; ; ++i )
  {
    while ( 1 )
    {
      v4 = (_BYTE *)*i;
      if ( *(_BYTE *)*i == 62 )
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
        if ( v5 == 62 && !v4[2] )
          break;
      }
      v3 = v1;
      ++i;
      ++v1;
      if ( v0 <= v3 )
        return __readfsqword(0x28u) ^ v15;
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
    _strcpy_chk(v14, v6, 768LL);
    _printf_chk(1LL, "dest_filename = %s", v14);
LABEL_8:
    v8 = (_BYTE *)*i;
    if ( *(_BYTE *)*i == 62 )
    {
      v9 = v8[1];
      if ( v9 )
        goto LABEL_15;
      v10 = open(v14, 577, 438LL);
      if ( v10 < 0 )
        goto LABEL_27;
      do
        v11 = fork();
      while ( v11 < 0 );
      if ( !v11 )
        goto LABEL_28;
      waitpid(v11, 0LL, 0);
      v8 = (_BYTE *)*i;
      if ( *(_BYTE *)*i == 62 )
        break;
    }
LABEL_21:
    v0 = unk_205B40;
    ++v1;
    if ( unk_205B40 <= v7 )
      return __readfsqword(0x28u) ^ v15;
  }
  v9 = v8[1];
LABEL_15:
  if ( v9 != 62 || v8[2] )
    goto LABEL_21;
  v10 = open(v14, 1089, 438LL);
  if ( v10 < 0 )
  {
LABEL_27:
    puts("open or no this file false!");
    return __readfsqword(0x28u) ^ v15;
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
  return __readfsqword(0x28u) ^ v15;
}
