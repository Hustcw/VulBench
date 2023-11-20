unsigned int __cdecl sub_9C0(char *a1, int a2, int a3)
{
  _BYTE *v3;
  size_t v4;
  unsigned int result;
  int i;
  int j;
  char *s;
  char v9[92];
  char v10[16];
  unsigned int v11;

  v11 = __readgsdword(0x14u);
  if ( a3 )
  {
    s = a1 - 4;
    for ( i = 0; i <= 3; ++i )
    {
      v3 = (_BYTE *)(*(_DWORD *)(unk_300C + 576) + i);
      *v3 = rand();
      if ( !*(_BYTE *)(*(_DWORD *)(unk_300C + 576) + i) )
        ++*(_BYTE *)(*(_DWORD *)(unk_300C + 576) + i);
    }
  }
  else
  {
    s = a1;
  }
  if ( MD5_Init(v9) != 1 )
  {
    perror("MD5_Init");
    exit(1);
  }
  v4 = strlen(s);
  if ( MD5_Update(v9, s, v4) != 1 )
  {
    perror("MD5_Update");
    exit(1);
  }
  if ( MD5_Final(v10, v9) != 1 )
  {
    perror("MD5_Final");
    exit(1);
  }
  for ( j = 0; j <= 15; ++j )
    sprintf((char *)(2 * j + a2), "%02x", (unsigned __int8)v10[j]);
  result = __readgsdword(0x14u) ^ v11;
  if ( result )
    sub_FF0();
  return result;
}
