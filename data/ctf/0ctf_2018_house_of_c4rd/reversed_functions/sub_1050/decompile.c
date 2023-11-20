__int64 __fastcall sub_1050(int a1, char *a2, unsigned __int64 a3)
{
  unsigned __int64 v4;
  ssize_t v5;

  v4 = 0LL;
  while ( v4 < a3 )
  {
    v5 = read(a1, &a2[v4], 1uLL);
    if ( v5 == -1 )
    {
      if ( *__errno_location() != 11 && *__errno_location() != 4 )
        return -1LL;
    }
    else
    {
      if ( !v5 || a2[v4] == 10 )
        return v4;
      v4 += v5;
    }
  }
  return v4;
}