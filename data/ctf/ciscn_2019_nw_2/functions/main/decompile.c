void __fastcall __noreturn main(__int64 a1, char **a2, char **a3)
{
  int v3;
  unsigned __int64 v4;

  v4 = __readfsqword(0x28u);
  sub_A40(a1, a2, a3);
  while ( 1 )
  {
    sub_A70();
    __isoc99_scanf("%d", &v3);
    _IO_getc(stdin);
    if ( v3 == 1 )
    {
      sub_AB0();
    }
    else if ( v3 == 2 )
    {
      sub_B70();
    }
    else
    {
      puts("invalid choice");
    }
  }
}
