unsigned __int64 sub_14A0()
{
  FILE **v0;
  __int64 v1;
  _QWORD *v2;
  int v3;
  _BYTE *v4;
  char *v5;
  unsigned __int64 v7;

  v0 = (FILE **)&unk_4020;
  v1 = 0LL;
  v7 = __readfsqword(0x28u);
  v2 = &unk_4020;
  while ( v2[1] )
  {
    ++v1;
    v2 += 2;
    if ( v1 == 8 )
      goto LABEL_4;
  }
  puts("Input the size:");
  v3 = sub_13E0() & 0xFFFFFFF8;
  if ( v3 > 128 )
    goto LABEL_4;
  do
  {
    if ( *(_DWORD *)v0 == v3 )
    {
      puts("I don't like the same size!");
      exit(0);
    }
    v0 += 2;
  }
  while ( &stdout != v0 );
  v4 = malloc(v3);
  if ( !v4 )
LABEL_4:
    exit(0);
  puts("Input the note:");
  v5 = (char *)&unk_4020 + 16 * v1;
  sub_1350(v4, v3);
  *(_DWORD *)v5 = v3;
  *((_QWORD *)v5 + 1) = v4;
  return __readfsqword(0x28u) ^ v7;
}
