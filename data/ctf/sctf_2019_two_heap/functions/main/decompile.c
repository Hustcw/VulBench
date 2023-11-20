void __fastcall __noreturn main(__int64 a1, char **a2, char **a3)
{
  int v3;
  __int64 v4;
  int v5;
  unsigned __int64 v6;

  v6 = __readfsqword(0x28u);
  sub_12D0(a1, a2, a3);
  v4 = 0LL;
  v5 = 0;
  puts("Welcome to SCTF:");
  sub_1350(&v4, 11LL);
  __printf_chk(1LL, &v4, 0xFFFFFFFFLL, 0xFFFFFFFFLL, 0xFFFFFFFFLL);
  while ( 1 )
  {
    while ( 1 )
    {
      v3 = sub_1440();
      if ( v3 != 1 )
        break;
      sub_14A0();
    }
    if ( v3 != 2 )
    {
      puts("exit.");
      exit(0);
    }
    sub_15A0();
  }
}
