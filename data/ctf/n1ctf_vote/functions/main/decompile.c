void __fastcall __noreturn main(int a1, char **a2, char **a3)
{
  int v3;
  unsigned __int64 v4;

  v4 = __readfsqword(0x28u);
  setvbuf(stdin, 0LL, 2, 0LL);
  alarm(0x1Eu);
  while ( 1 )
  {
    sub_400C00("0: Create");
    sub_400C00("1: Show");
    sub_400C00("2: Vote");
    sub_400C00("3: Result");
    sub_400C00("4: Cancel");
    sub_400C00("5: Exit");
    sub_400C52("Action: ");
    if ( (unsigned int)__isoc99_scanf("%d", &v3) == -1 )
      break;
    if ( !v3 )
      sub_400D2C();
    if ( v3 == 1 )
      sub_400E02();
    if ( v3 == 2 )
      sub_400F09();
    if ( v3 == 3 )
      sub_400FCB();
    if ( v3 == 4 )
      sub_40109D();
    if ( v3 == 5 )
    {
      sub_400C00("Bye");
      exit(0);
    }
  }
  exit(1);
}
