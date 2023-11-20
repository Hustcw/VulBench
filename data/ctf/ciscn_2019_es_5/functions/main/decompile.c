int __cdecl main(int argc, const char **argv, const char **envp)
{
  init(argc, argv, envp);
  while ( 1 )
  {
    menu();
    switch ( read_int() )
    {
      case 1:
        Create();
        break;
      case 2:
        Edit();
        break;
      case 3:
        Show();
        break;
      case 4:
        Delete();
        break;
      case 5:
        exit(0);
      default:
        puts("Invalid choice!");
        break;
    }
  }
}
