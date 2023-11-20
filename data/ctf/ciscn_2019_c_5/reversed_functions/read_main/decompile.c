void read_main()
{
  int v0;
  char s[16];
  char buf[40];
  unsigned __int64 v3;

  v3 = __readfsqword(0x28u);
  puts("Welcome to the story kingdom.");
  puts("What's your name?");
  read(0, buf, 0x20uLL);
  _printf_chk(1LL, buf);
  puts("Please input your ID.");
  read(0, s, 8uLL);
  puts(s);
  while ( 1 )
  {
    menu();
    _isoc99_scanf("%d", &v0);
    getchar();
    switch ( v0 )
    {
      case 1:
        add();
        break;
      case 2:
        edit();
        break;
      case 3:
        show();
        break;
      case 4:
        delete();
        break;
      case 5:
        puts("Goodbye~");
        exit(0);
      default:
        puts("Wrong choice!");
        return;
    }
  }
}