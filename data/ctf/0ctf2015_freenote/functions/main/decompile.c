__int64 __fastcall main(int a1, char **a2, char **a3)
{
  sub_4009FD();
  sub_400A49();
  while ( 1 )
  {
    switch ( sub_400998() )
    {
      case 1:
        sub_400B14();
        break;
      case 2:
        sub_400BC2();
        break;
      case 3:
        sub_400D87();
        break;
      case 4:
        sub_400F7D();
        break;
      case 5:
        puts("Bye");
        return 0LL;
      default:
        puts("Invalid!");
        break;
    }
  }
}
