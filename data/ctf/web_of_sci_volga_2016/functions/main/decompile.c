__int64 __fastcall main(int a1, char **a2, char **a3)
{
  unsigned int v3;

  setvbuf(stdout, 0LL, 2, 0LL);
  v3 = time(0LL);
  srand(v3);
  if ( sub_4007CD() )
  {
    puts("Service is provided for humans only!");
    return 1LL;
  }
  else
  {
    sub_400E1C();
    return 0LL;
  }
}
