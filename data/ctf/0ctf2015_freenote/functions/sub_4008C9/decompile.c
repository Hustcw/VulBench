__int64 __fastcall sub_4008C9(__int64 a1, int a2)
{
  int i;

  if ( a2 <= 0 )
    return 0LL;
  for ( i = 0; a2 - 1 > i && (int)read(0, (void *)(i + a1), 1uLL) > 0 && *(_BYTE *)(i + a1) != 10; ++i )
    ;
  *(_BYTE *)(i + a1) = 0;
  return (unsigned int)i;
}
