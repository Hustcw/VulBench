void __fastcall __noreturn main(int a1, char **a2, char **a3)
{
  int v3;
  unsigned __int64 v4;

  v4 = __readfsqword(0x28u);
  setbuf(stdin, 0LL);
  setbuf(stdout, 0LL);
  setbuf(stderr, 0LL);
  alarm(0x3Cu);
  puts("welcome to the note 2018~");
  while ( 1 )
  {
    sub_BD2();
    __isoc99_scanf("%d", &v3);
    switch ( v3 )
    {
      case 2:
        sub_D73();
        break;
      case 3:
        sub_E37();
        break;
      case 1:
        sub_C0E();
        break;
      default:
        puts("invalid~");
        break;
    }
  }
}
