void __fastcall sub_B72(char *a1, __int64 a2)
{
  unsigned __int64 i;

  for ( i = 0LL; i < a2 - 1; ++i )
  {
    read(0, &a1[i], 1uLL);
    if ( a1[i] == 10 )
    {
      a1[i] = 0;
      break;
    }
  }
  a1[i] = 0;
}