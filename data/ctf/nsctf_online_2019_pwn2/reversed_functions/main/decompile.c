__int64 __fastcall main(__int64 a1, char **a2, char **a3)
{
  int v4;
  unsigned __int64 v5;

  v5 = __readfsqword(0x28u);
  sub_A00(a1, a2, a3);
  while ( 1 )
  {
    menu();
    _isoc99_scanf("%d", &v4);
    switch ( v4 )
    {
      case 1:
        add();
        break;
      case 2:
        delete();
        break;
      case 3:
        show();
        break;
      case 4:
        update();
        break;
      case 5:
        edit();
        break;
      case 6:
        return 0LL;
      default:
        puts("Wrong choice");
        break;
    }
  }
}