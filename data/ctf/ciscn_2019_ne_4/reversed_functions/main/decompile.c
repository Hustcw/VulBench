__int64 __fastcall main(int a1, char **a2, char **a3)
{
  int v4;

  while ( 1 )
  {
    sub_B5A();
    v4 = sub_BE0(v4);
    switch ( v4 )
    {
      case 1:
        puts("Have a good day!");
        sub_C46();
        break;
      case 2:
        puts("Here's a great thing!");
        sub_E98();
        break;
      case 3:
        puts("Are you sure?");
        sub_FA4();
        break;
      case 4:
        puts("Is there anything nice in the ticket?");
        sub_1138();
        break;
      case 5:
        puts("See you!");
        return 0LL;
      default:
        puts("Wrong choice!!!Please again!!!");
        break;
    }
  }
}