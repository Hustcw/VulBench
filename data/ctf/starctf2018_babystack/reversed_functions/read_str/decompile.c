__int64 __fastcall read_str(int a1, char *a2, unsigned __int64 a3)
{
  unsigned __int64 v5;
  ssize_t v6;

  v5 = 0LL;
  while ( v5 < a3 )
  {
    v6 = read(a1, &a2[v5], a3 - v5);
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