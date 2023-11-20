void __fastcall __noreturn main(int a1, char **a2, char **a3)
{
  char v3[8];
  unsigned __int64 v4;

  v4 = __readfsqword(0x28u);
  sub_A4A();
  while ( 1 )
  {
    sub_AFE();
    read(0, v3, 2uLL);
    if ( v3[0] == 69 )
      break;
    if ( v3[0] > 69 )
    {
      if ( v3[0] == 70 )
      {
        sub_C62();
      }
      else if ( v3[0] == 83 )
      {
        sub_CB5();
      }
    }
    else if ( v3[0] == 65 )
    {
      sub_D0E();
    }
  }
  exit(0);
}
