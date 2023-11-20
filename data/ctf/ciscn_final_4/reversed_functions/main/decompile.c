int __cdecl __noreturn main(int argc, const char **argv, const char **envp)
{
  __pid_t v3;
  int v4;
  __pid_t v5;
  char s[264];
  unsigned __int64 v7;

  v7 = __readfsqword(0x28u);
  puts("and bewared!, something is watching you !!");
  memset(s, 0, 0x100uLL);
  puts("what is your name? ");
  read(0, s, 0xFFuLL);
  printf("hi ! %s\n", s);
  while ( 1 )
  {
    while ( 1 )
    {
      menu();
      _isoc99_scanf("%d", &v4);
      if ( v4 != 2 )
        break;
      delete();
    }
    if ( v4 > 2 )
    {
      if ( v4 == 3 )
      {
        mwrite();
      }
      else
      {
        if ( v4 == 4 )
          exit(0);
LABEL_17:
        puts("Invalid choice!");
      }
    }
    else
    {
      if ( v4 != 1 )
        goto LABEL_17;
      new();
    }
  }
}