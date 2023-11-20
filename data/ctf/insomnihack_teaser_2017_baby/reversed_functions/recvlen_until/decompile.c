__int64 __fastcall recvlen_until(int a1, const char *a2, unsigned __int64 a3, const char *a4)
{
  unsigned __int64 v7;
  ssize_t v8;

  v7 = 0LL;
  while ( v7 < a3 )
  {
    v8 = recv(a1, (void *)&a2[v7], a3 - v7, 0);
    if ( v8 == -1 )
    {
      if ( *__errno_location() != 11 && *__errno_location() != 4 )
        return -1LL;
    }
    else
    {
      if ( !v8 )
        return v7;
      v7 += v8;
      if ( strstr(a2, a4) )
        return v7;
    }
  }
  return v7;
}