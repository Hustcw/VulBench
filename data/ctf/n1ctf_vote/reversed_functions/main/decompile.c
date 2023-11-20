void __fastcall __noreturn main(int a1, char **a2, char **a3)
{
  int v3;
  unsigned __int64 v4;

  v4 = __readfsqword(0x28u);
  setvbuf(stdin, 0LL, 2, 0LL);
  alarm(0x1Eu);
  while ( 1 )
  {
    println("0: Create");
    println("1: Show");
    println("2: Vote");
    println("3: Result");
    println("4: Cancel");
    println("5: Exit");
    print("Action: ");
    if ( (unsigned int)__isoc99_scanf("%d", &v3) == -1 )
      break;
    if ( !v3 )
      create();
    if ( v3 == 1 )
      show();
    if ( v3 == 2 )
      vote();
    if ( v3 == 3 )
      result();
    if ( v3 == 4 )
      cancel();
    if ( v3 == 5 )
    {
      println("Bye");
      exit(0);
    }
  }
  exit(1);
}