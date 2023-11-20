void __fastcall read_str(char *a1, unsigned int a2)
{
  unsigned int v2;

  v2 = 0;
  do
  {
    if ( read(0, &a1[v2], 1uLL) == -1 )
      exit(0);
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