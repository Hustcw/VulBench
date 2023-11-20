unsigned __int64 sub_1790()
{
  char *v0;
  int v1;
  unsigned int v2;
  __int64 v3;
  char *v4;
  _QWORD *v5;
  int v6;
  size_t v7;
  char *v8;
  char v10[776];
  unsigned __int64 v11;

  v11 = __readfsqword(0x28u);
  fgets(v10, 768, stdin);
  v0 = v10;
  do
  {
    v1 = *(_DWORD *)v0;
    v0 += 4;
    v2 = ~v1 & (v1 - 16843009) & 0x80808080;
  }
  while ( !v2 );
  if ( (~v1 & (v1 - 16843009) & 0x8080) == 0 )
  {
    v2 >>= 16;
    v0 += 2;
  }
  v3 = &v0[-__CFADD__((_BYTE)v2, (_BYTE)v2) - 3] - v10 - 1;
  if ( v10[v3] == 10 )
    v10[v3] = 0;
  v4 = strtok(v10, " ");
  if ( v4 )
  {
    v5 = &unk_204040;
    v6 = 0;
    do
    {
      ++v6;
      ++v5;
      v7 = strlen(v4);
      v8 = (char *)malloc(v7);
      *(v5 - 1) = v8;
      strcpy(v8, v4);
      v4 = strtok(0LL, " ");
    }
    while ( v4 );
  }
  else
  {
    v6 = 0;
  }
  unk_205B40 = v6;
  return __readfsqword(0x28u) ^ v11;
}
