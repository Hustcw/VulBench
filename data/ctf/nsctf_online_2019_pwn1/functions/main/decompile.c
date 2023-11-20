__int64 __fastcall main(int a1, char **a2, char **a3)
{
  int v4;
  unsigned __int64 v5;

  v5 = __readfsqword(0x28u);
  v4 = 0;
  sub_A10();
  while ( 1 )
  {
    sub_A7D();
    _isoc99_scanf("%d", &v4);
    switch ( v4 )
    {
      case 1:
        sub_AC0();
        break;
      case 2:
        sub_C1D();
        break;
      case 3:
        sub_D1B();
        break;
      case 4:
        sub_D2E();
        break;
      case 5:
        return 0LL;
      default:
        puts("Wrong choice");
        break;
    }
  }
}
