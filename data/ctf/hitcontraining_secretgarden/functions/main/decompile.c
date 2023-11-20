int __cdecl main(int argc, const char **argv, const char **envp)
{
  char buf[10];
  unsigned __int64 v5;

  v5 = __readfsqword(0x28u);
  init(argc, argv, envp);
  while ( 1 )
  {
    menu();
    read(0, buf, 8uLL);
    switch ( atoi(buf) )
    {
      case 1:
        add();
        break;
      case 2:
        visit();
        break;
      case 3:
        del();
        break;
      case 4:
        clean();
        break;
      case 5:
        puts("See you next time.");
        exit(0);
      default:
        puts("Invalid choice");
        break;
    }
  }
}
