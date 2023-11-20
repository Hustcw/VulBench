__int64 __fastcall read_str(char *a1, unsigned int a2)
{
  unsigned int i; // [rsp+14h] [rbp-Ch]

  for ( i = 0; (int)i < (int)a2; ++i )
  {
    read(0, &a1[i], 1uLL);
    if ( a1[i] == 10 )
    {
      a1[i] = 0;
      return i;
    }
  }
  fflush(stdin);
  return a2;
}