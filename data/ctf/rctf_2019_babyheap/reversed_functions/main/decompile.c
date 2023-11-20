int __cdecl main(int argc, const char **argv, const char **envp)
{
  while ( 1 )
  {
    menu();
    switch ( get_int() )
    {
      case 1:
        add();
        break;
      case 2:
        edit();
        break;
      case 3:
        delete();
        break;
      case 4:
        show();
        break;
      case 5:
        puts("See you next time!");
        exit(0);
      default:
        puts("Invalid choice!");
        break;
    }
  }
}