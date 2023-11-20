int __cdecl __noreturn main(int argc, const char **argv, const char **envp)
{
  int atoi;

  init(argc, argv, envp);
  while ( 1 )
  {
    while ( 1 )
    {
      while ( 1 )
      {
        menu();
        atoi = read_atoi();
        if ( atoi != 3 )
          break;
        dele();
      }
      if ( atoi > 3 )
        break;
      if ( atoi == 1 )
      {
        create();
      }
      else
      {
        if ( atoi != 2 )
          goto LABEL_15;
        show();
      }
    }
    if ( atoi == 5 )
    {
      puts_flush("bye,bye!!");
      exit(0);
    }
    if ( atoi != 666 )
LABEL_15:
      exit(0);
    backdoor();
  }
}
