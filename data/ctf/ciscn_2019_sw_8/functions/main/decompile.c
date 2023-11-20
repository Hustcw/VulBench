int __cdecl __noreturn main(int argc, const char **argv, const char **envp)
{
  int i;
  unsigned __int64 v4;

  v4 = __readfsqword(0x28u);
  setvbuf(_bss_start, 0LL, 2, 0LL);
  setvbuf(stdin, 0LL, 2, 0LL);
  setvbuf(stderr, 0LL, 2, 0LL);
  alarm(0x1Eu);
  while ( 1 )
  {
    while ( 1 )
    {
      while ( 1 )
      {
        menu();
        __isoc99_scanf("%d", &i);
        if ( i != 3 )
          break;
        show();
      }
      if ( i > 3 )
        break;
      if ( i == 1 )
      {
        add();
      }
      else
      {
        if ( i != 2 )
          goto LABEL_15;
        edit();
      }
    }
    if ( i == 4 )
    {
      del();
    }
    else
    {
      if ( i != 666 )
LABEL_15:
        exit(0);
      magic();
    }
  }
}
