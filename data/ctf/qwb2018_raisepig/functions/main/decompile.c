void __fastcall __noreturn main(int a1, char **a2, char **a3)
{
  char buf[24];
  unsigned __int64 v4;

  v4 = __readfsqword(0x28u);
  sub_1160();
  while ( 1 )
  {
    sub_B90();
    read(0, buf, 8uLL);
    switch ( atoi(buf) )
    {
      case 1:
        sub_C8F();
        break;
      case 2:
        sub_101E();
        break;
      case 3:
        sub_E3E();
        break;
      case 4:
        sub_F42();
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
