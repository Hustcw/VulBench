unsigned __int64 __fastcall sub_400932(__int64 a1, unsigned int a2)
{
  unsigned __int64 result;
  unsigned int i;

  for ( i = 0; ; ++i )
  {
    result = i;
    if ( i >= a2 )
      break;
    read(0, (void *)(i + a1), 1uLL);
    if ( *(_BYTE *)(i + a1) == 10 || i == a2 - 1 )
    {
      result = i + a1;
      *(_BYTE *)result = 0;
      return result;
    }
  }
  return result;
}
