__int64 __fastcall sub_400957(int a1, __int64 a2, unsigned __int64 a3)
{
  unsigned __int64 v5;
  ssize_t v6;

  v5 = 0LL;
  while ( v5 < a3 )
  {
    v6 = read(a1, (void *)(v5 + a2), a3 - v5);
    if ( v6 == -1 )
    {
      if ( *_errno_location() != 11 && *_errno_location() != 4 )
        return -1LL;
    }
    else
    {
      if ( !v6 )
        return v5;
      v5 += v6;
    }
  }
  return v5;
}
