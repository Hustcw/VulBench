_BYTE *__fastcall read_context(__int64 a1, unsigned int a2)
{
  _BYTE *result;
  unsigned int v3;

  v3 = 0;
  do
  {
    if ( read(0, (void *)(v3 + a1), 1uLL) == -1 )
      exit(0);
    if ( *(_BYTE *)(v3 + a1) == 10 )
    {
      result = (_BYTE *)(v3 + a1);
      *result = 0;
      return result;
    }
    ++v3;
  }
  while ( v3 < a2 );
  result = (_BYTE *)(v3 - 1 + a1);
  *result = 0;
  return result;
}
