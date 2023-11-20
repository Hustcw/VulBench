__int64 __fastcall sub_1249(__int64 a1, unsigned int a2)
{
  unsigned int i;

  for ( i = 0; (int)i < (int)a2; ++i )
  {
    read(0, (void *)((int)i + a1), 1uLL);
    if ( *(_BYTE *)((int)i + a1) == 10 )
    {
      *(_BYTE *)((int)i + a1) = 0;
      return i;
    }
  }
  fflush(stdin);
  return a2;
}
