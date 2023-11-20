__int64 __fastcall main(__int64 a1, char **a2, char **a3)
{
  init();
  init2();
  while ( 1 )
  {
    switch ( menu_and_read_choice() )
    {
      case 1:
        list();
        break;
      case 2:
        new();
        break;
      case 3:
        edit();
        break;
      case 4:
        delete();
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