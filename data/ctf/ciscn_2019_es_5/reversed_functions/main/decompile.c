int __cdecl main(int argc, const char **argv, const char **envp)
{
  init(argc, argv, envp);
  while ( 1 )
  {
    menu();
    switch ( (unsigned int)read_int() )
    {
      case 1u:
        Create();
        break;
      case 2u:
        Edit();
        break;
      case 3u:
        Show();
        break;
      case 4u:
        Delete();
        break;
      case 5u:
        exit(0);
      default:
        puts("Invalid choice!");
        break;
    }
  }
}