void __fastcall read_str_impl(char *a1, int a2, char a3)
{
  int i;

  for ( i = 0; i < a2; ++i )
  {
    if ( (unsigned int)read(0, &a1[i], 1uLL) != 1 )
      exit(-1);
    if ( a3 == a1[i] )
    {
      a1[i] = 0;
      return;
    }
  }
  a1[a2 - 1] = 0;
}