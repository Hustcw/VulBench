void __fastcall read_str(char *a1, unsigned __int64 a2)
{
  unsigned __int64 v2;

  v2 = 0LL;
  do
  {
    if ( read(0, &a1[v2], 1uLL) == -1 )
      exit(1);
    if ( a1[v2] == 10 )
    {
      a1[v2] = 0;
      return;
    }
    ++v2;
  }
  while ( v2 < a2 );
  a1[v2 - 1] = 0;
}