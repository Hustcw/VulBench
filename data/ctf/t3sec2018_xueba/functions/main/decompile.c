void __fastcall __noreturn main(int a1, char **a2, char **a3)
{
  int v3;
  unsigned __int64 v4;

  v4 = __readfsqword(0x28u);
  sub_A50();
  puts("Welcome to the xueba note system");
  while ( 1 )
  {
    sub_A93();
    _isoc99_scanf("%d", &v3);
    switch ( v3 )
    {
      case 1:
        sub_B0E();
        break;
      case 2:
        sub_C7E();
        break;
      case 3:
        sub_D3F();
        break;
      case 4:
        sub_E11();
        break;
      case 5:
        puts("Bye bye,hope you get good grades");
        exit(0);
      default:
        puts("Invalid option!");
        exit(0);
    }
  }
}
