void __fastcall sub_400932(char *a1, unsigned int a2)
{
  unsigned int i;

  for ( i = 0; i < a2; ++i )
  {
    read(0, &a1[i], 1uLL);
    if ( a1[i] == 10 || i == a2 - 1 )
    {
      a1[i] = 0;
      return;
    }
  }
}