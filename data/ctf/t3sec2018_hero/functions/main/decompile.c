int __cdecl main(int argc, const char **argv, const char **envp)
{
  char buf[24];
  unsigned __int64 v5;

  v5 = __readfsqword(0x28u);
  Init();
  puts("Do you want to be superhero?");
  while ( 1 )
  {
    menu();
    read(0, buf, 0x10uLL);
    switch ( atoi(buf) )
    {
      case 1:
        add();
        break;
      case 2:
        show();
        break;
      case 3:
        edit();
        break;
      case 4:
        del();
        break;
      case 5:
        puts("Bye bye!");
        exit(0);
      default:
        puts("Invalid choice!");
        break;
    }
  }
}
