int __cdecl main(int argc, const char **argv, const char **envp)
{
  void (**v4)(void);
  char buf[8];
  unsigned __int64 v6;

  v6 = __readfsqword(0x28u);
  setvbuf(stdout, 0LL, 2, 0LL);
  setvbuf(stdin, 0LL, 2, 0LL);
  v4 = (void (**)(void))malloc(0x10uLL);
  *v4 = (void (*)(void))hello_message;
  v4[1] = (void (*)(void))goodbye_message;
  (*v4)();
  while ( 1 )
  {
    menu();
    read(0, buf, 8uLL);
    switch ( atoi(buf) )
    {
      case 1:
        show_item();
        break;
      case 2:
        add_item();
        break;
      case 3:
        change_item();
        break;
      case 4:
        remove_item();
        break;
      case 5:
        v4[1]();
        exit(0);
      default:
        puts("invaild choice!!!");
        break;
    }
  }
}
