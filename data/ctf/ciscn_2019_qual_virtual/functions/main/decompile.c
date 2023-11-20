__int64 __fastcall main(__int64 a1, char **a2, char **a3)
{
  char *s;
  __int64 v5;
  __int64 v6;
  __int64 v7;
  void *ptr;

  sub_401DA9(a1, a2, a3);
  s = (char *)malloc(0x20uLL);
  v5 = sub_4013B4(64LL);
  v6 = sub_4013B4(128LL);
  v7 = sub_4013B4(64LL);
  ptr = malloc(0x400uLL);
  puts("Your program name:");
  sub_401E14(s, 32LL);
  puts("Your instruction:");
  sub_401E14(ptr, 1024LL);
  sub_40161D(v6, ptr);
  puts("Your stack data:");
  sub_401E14(ptr, 1024LL);
  sub_40151A(v5, ptr);
  if ( (unsigned int)sub_401967(v6, v5, v7) )
  {
    puts("-------");
    puts(s);
    sub_4018CA(v5);
    puts("-------");
  }
  else
  {
    puts("Your Program Crash :)");
  }
  free(ptr);
  sub_401381(v6);
  sub_401381(v5);
  sub_401381(v7);
  return 0LL;
}
