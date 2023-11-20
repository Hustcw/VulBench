unsigned __int64 sub_DAF()
{
  int v1;
  char s[16];
  char buf[40];
  unsigned __int64 v4;

  v4 = __readfsqword(0x28u);
  puts("Welcome to the story kingdom.");
  puts("What's your name?");
  read(0, buf, 0x20uLL);
  _printf_chk(1LL, buf);
  puts("Please input your ID.");
  read(0, s, 8uLL);
  puts(s);
  while ( 1 )
  {
    sub_B7D();
    _isoc99_scanf("%d", &v1);
    getchar();
    switch ( v1 )
    {
      case 1:
        sub_BE9();
        break;
      case 2:
        sub_D1F();
        break;
      case 3:
        sub_D0C();
        break;
      case 4:
        sub_D32();
        break;
      case 5:
        puts("Goodbye~");
        exit(0);
      default:
        puts("Wrong choice!");
        return __readfsqword(0x28u) ^ v4;
    }
  }
}
