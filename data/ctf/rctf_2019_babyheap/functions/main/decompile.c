int __cdecl main(int argc, const char **argv, const char **envp)
{
  init(argc, argv, envp);
  while ( 1 )
  {
    menu();
    switch ( (unsigned int)get_int() )
    {
      case 1u:
        add();
        break;
      case 2u:
        edit();
        break;
      case 3u:
        delete();
        break;
      case 4u:
        show();
        break;
      case 5u:
        puts("See you next time!");
        exit(0);
      default:
        puts("Invalid choice!");
        break;
    }
  }
}
