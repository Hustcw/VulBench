_BYTE *__fastcall sub_400B76(__int64 a1, unsigned __int64 a2)
{
  _BYTE *result;
  unsigned __int64 v3;

  v3 = 0LL;
  do
  {
    if ( read(0, (void *)(a1 + v3), 1uLL) == -1 )
      exit(1);
    if ( *(_BYTE *)(a1 + v3) == 10 )
    {
      result = (_BYTE *)(a1 + v3);
      *(_BYTE *)(a1 + v3) = 0;
      return result;
    }
    ++v3;
  }
  while ( v3 < a2 );
  result = (_BYTE *)(v3 - 1 + a1);
  *result = 0;
  return result;
}
