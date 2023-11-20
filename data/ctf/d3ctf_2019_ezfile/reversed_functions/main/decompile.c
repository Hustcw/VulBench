int __cdecl __noreturn main(int argc, const char **argv, const char **envp)
{
  int Number; // eax

  fd = open("/dev/urandom", 0);
  if ( fd == -1 )
  {
    myputs("error in opening /dev/urandom", 1);
    exit(0);
  }
  __isoc99_scanf("%90s", name);
  printf("welcome!%s.\n", name);
  key = (char *)malloc(0x300uLL);
  if ( !key )
  {
    myputs("error in malloc key", 1);
    exit(0);
  }
  if ( !re_entry )
  {
    re_entry = 1;
    if ( read(fd, key, 0x300uLL) != 768 )
    {
      myputs("error in reading /deb/urandom", 1);
      exit(0);
    }
    close(fd);
    while ( 1 )
    {
      Number = getNumber();
      switch ( Number )
      {
        case 2:
          deleteNote();
          break;
        case 3:
          encryptNode();
          break;
        case 1:
          addNote();
          break;
      }
    }
  }
  myputs("re_entry detected!", 1);
  exit(0);
}