unsigned __int64 __fastcall sub_B20(__int64 a1, unsigned int a2)
{
  char buf;
  unsigned int i;
  unsigned __int64 v5;

  v5 = __readfsqword(0x28u);
  for ( i = 0; i < a2; ++i )
  {
    buf = 0;
    if ( read(0, &buf, 1uLL) < 0 )
    {
      puts("Read error.");
      exit(-2);
    }
    if ( buf == 10 )
    {
      *(_BYTE *)(i + a1) = 0;
      return __readfsqword(0x28u) ^ v5;
    }
    *(_BYTE *)(a1 + i) = buf;
  }
  *(_BYTE *)(i + a1) = 0;
  return __readfsqword(0x28u) ^ v5;
}
