void __fastcall __noreturn main(int a1, char **a2, char **a3)
{
  int v3;
  char s[24];
  unsigned __int64 v5;

  v5 = __readfsqword(0x28u);
  sub_400882();
  while ( 1 )
  {
    while ( 1 )
    {
      sub_4008F4();
      memset(s, 0, 0x10uLL);
      read(0, s, 0xFuLL);
      v3 = atoi(s);
      if ( v3 != 2 )
        break;
      sub_400A80();
    }
    if ( v3 == 3 )
    {
      sub_400B41();
    }
    else
    {
      if ( v3 != 1 )
        exit(0);
      sub_4009A7();
    }
  }
}
