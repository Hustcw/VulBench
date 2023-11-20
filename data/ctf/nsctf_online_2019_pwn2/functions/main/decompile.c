__int64 __fastcall main(int a1, char **a2, char **a3)
{
  int v4;
  unsigned __int64 v5;

  v5 = __readfsqword(0x28u);
  sub_A00();
  while ( 1 )
  {
    sub_A9B();
    _isoc99_scanf("%d", &v4);
    switch ( v4 )
    {
      case 1:
        sub_AEA();
        break;
      case 2:
        sub_BB1();
        break;
      case 3:
        sub_BF3();
        break;
      case 4:
        sub_C60();
        break;
      case 5:
        sub_C1B();
        break;
      case 6:
        return 0LL;
      default:
        puts("Wrong choice");
        break;
    }
  }
}
