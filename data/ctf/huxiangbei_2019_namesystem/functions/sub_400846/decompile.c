unsigned __int64 __fastcall sub_400846(__int64 a1, int a2)
{
  char buf;
  int i;
  unsigned __int64 v5;

  v5 = __readfsqword(0x28u);
  for ( i = 0; i < a2; ++i )
  {
    if ( (unsigned int)read(0, &buf, 1uLL) == -1 )
    {
      puts("error!");
      exit(0);
    }
    *(_BYTE *)(a1 + i) = buf;
    if ( buf == 10 )
    {
      *(_BYTE *)(i + a1) = 0;
      return __readfsqword(0x28u) ^ v5;
    }
  }
  *(_BYTE *)(i - 1LL + a1) = 0;
  return __readfsqword(0x28u) ^ v5;
}
