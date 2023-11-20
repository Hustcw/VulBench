int __cdecl sub_80487A7(void *src)
{
  _BYTE *dest;
  int v3;
  int v4;
  int v5;

  v5 = dword_8049FB8;
  v4 = 0;
  v3 = 0;
  while ( v5 )
  {
    v4 = v5;
    v5 = *(_DWORD *)(v5 + 140);
    if ( (unsigned int)++v3 > 0xF423F )
    {
      puts("[MEMORY ERROR]");
      exit(0);
    }
  }
  dest = malloc(0x90u);
  memcpy(dest, src, 0x8Cu);
  dest[139] = 0;
  *(_DWORD *)(v4 + 140) = dest;
  return ++dword_8049FB4;
}
