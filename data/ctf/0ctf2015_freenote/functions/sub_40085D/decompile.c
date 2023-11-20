__int64 __fastcall sub_40085D(__int64 a1, int a2)
{
  int i;
  int v4;

  if ( a2 <= 0 )
    return 0LL;
  for ( i = 0; i < a2; i += v4 )
  {
    v4 = read(0, (void *)(a1 + i), a2 - i);
    if ( v4 <= 0 )
      break;
  }
  return (unsigned int)i;
}
