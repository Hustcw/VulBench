void __fastcall __noreturn main(int a1, char **a2, char **a3)
{
  char buf[24];
  unsigned __int64 v4;

  v4 = __readfsqword(0x28u);
  while ( 1 )
  {
    menu();
    read(0, buf, 8uLL);
    switch ( atoi(buf) )
    {
      case 1:
        raise();
        break;
      case 2:
        visit();
        break;
      case 3:
        eat();
        break;
      case 4:
        eat_farm();
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