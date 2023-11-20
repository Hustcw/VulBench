__int64 __fastcall sub_B72(__int64 a1, __int64 a2)
{
  __int64 result;
  unsigned __int64 i;

  for ( i = 0LL; i < a2 - 1; ++i )
  {
    read(0, (void *)(a1 + i), 1uLL);
    if ( *(_BYTE *)(a1 + i) == 10 )
    {
      *(_BYTE *)(a1 + i) = 0;
      break;
    }
  }
  result = a1 + i;
  *(_BYTE *)(a1 + i) = 0;
  return result;
}
