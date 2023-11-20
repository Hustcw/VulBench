__int64 __fastcall sub_401E85(__int64 a1, int a2, char a3)
{
  unsigned int i;

  for ( i = 0; (int)i < a2; ++i )
  {
    if ( (unsigned int)read(0, (void *)((int)i + a1), 1uLL) != 1 )
      exit(-1);
    if ( a3 == *(_BYTE *)((int)i + a1) )
    {
      *(_BYTE *)((int)i + a1) = 0;
      return i;
    }
  }
  *(_BYTE *)(a2 - 1LL + a1) = 0;
  return (unsigned int)(a2 - 1);
}
