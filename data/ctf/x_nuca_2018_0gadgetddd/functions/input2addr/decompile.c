__int64 __fastcall input2addr(__int64 a1, signed int a2)
{
  char buf;
  unsigned int i;
  unsigned __int64 v5;

  v5 = __readfsqword(0x28u);
  for ( i = 0; (int)i <= a2; ++i )
  {
    if ( read(0, &buf, 1uLL) < 0 )
      exit(1);
    *(_BYTE *)(a1 + (int)i) = buf;
    if ( *(_BYTE *)((int)i + a1) == 10 )
    {
      *(_BYTE *)((int)i + a1) = 0;
      return i;
    }
  }
  return i;
}
