__int64 __fastcall sub_DA8(__int64 a1, int a2)
{
  __int64 v3;
  ssize_t v4;

  if ( !a2 )
    return 0LL;
  v3 = 0LL;
  while ( a2 > v3 )
  {
    v4 = read(0, (void *)(v3 + a1), a2 - v3);
    if ( v4 > 0 )
      v3 += v4;
  }
  return v3;
}
