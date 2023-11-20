void __fastcall __noreturn main(__int64 a1, char **a2, char **a3)
{
  int v3; // [rsp+4h] [rbp-24h] BYREF
  unsigned __int64 v4; // [rsp+8h] [rbp-20h]

  v4 = __readfsqword(0x28u);
  sub_A40();
  while ( 1 )
  {
    sub_A70();
    __isoc99_scanf("%d", &v3);
    _IO_getc(stdin);
    if ( v3 == 1 )
    {
      new_note();
    }
    else if ( v3 == 2 )
    {
      free_note();
    }
    else
    {
      puts("invalid choice");
    }
  }
}