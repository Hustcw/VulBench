void __fastcall __noreturn main(int a1, char **a2, char **a3)
{
  int v3;
  unsigned __int64 v4;

  v4 = __readfsqword(0x28u);
  sub_AEB();
  puts("Welcome to the Ne0's bus!");
  while ( 1 )
  {
    while ( 1 )
    {
      while ( 1 )
      {
        sub_BEF();
        __isoc99_scanf("%d", &v3);
        if ( v3 != 2 )
          break;
        sub_E0B();
      }
      if ( v3 > 2 )
        break;
      if ( v3 != 1 )
        goto LABEL_13;
      sub_CAA();
    }
    if ( v3 != 3 )
    {
      if ( v3 == 4 )
        exit(0);
LABEL_13:
      puts("Invalid choice!");
      exit(0);
    }
    sub_E9E();
  }
}
