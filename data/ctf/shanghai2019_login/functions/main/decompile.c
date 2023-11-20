__int64 __fastcall main(int a1, char **a2, char **a3)
{
  int v4;
  unsigned __int64 v5;

  v5 = __readfsqword(0x28u);
  sub_400806();
  while ( 1 )
  {
    sub_40084F();
    v4 = 0;
    puts("Choice:");
    _isoc99_scanf("%d", &v4);
    switch ( v4 )
    {
      case 1:
        sub_400A67();
        break;
      case 2:
        sub_4008C5();
        break;
      case 3:
        sub_400C2A();
        break;
      case 4:
        sub_400D05();
        break;
      case 5:
        puts("Exit");
        return 0LL;
      default:
        puts("What?");
        break;
    }
  }
}
