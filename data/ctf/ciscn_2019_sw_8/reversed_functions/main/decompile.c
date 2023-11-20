int __cdecl __noreturn main(int argc, const char **argv, const char **envp)
{
  int i;

  while ( 1 )
  {
    while ( 1 )
    {
      while ( 1 )
      {
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