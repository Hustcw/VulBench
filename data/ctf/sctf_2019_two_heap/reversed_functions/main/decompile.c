void __fastcall __noreturn main(int rdi0, char **a2, char **a3)
{
  int v3;
  _BYTE a1[8];
  int v5;
  unsigned __int64 v6;

  v6 = __readfsqword(0x28u);
  *(_QWORD *)a1 = 0LL;
  v5 = 0;
  puts("Welcome to SCTF:");
  sub_1350(a1, 11);
  __printf_chk(1LL, a1, 0xFFFFFFFFLL, 0xFFFFFFFFLL, 0xFFFFFFFFLL);
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