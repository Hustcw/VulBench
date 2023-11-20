__int64 __fastcall sendlen(int a1, __int64 a2, unsigned __int64 a3)
{
  unsigned __int64 v5;
  ssize_t v6;

  v5 = 0LL;
  while ( v5 < a3 )
  {
    v6 = send(a1, (const void *)(a2 + v5), a3 - v5, 0);
    if ( v6 == -1 )
    {
      if ( *__errno_location() != 11 && *__errno_location() != 4 )
        return -1LL;
    }
    else
    {
      v5 += v6;
    }
  }
  return v5;
}
