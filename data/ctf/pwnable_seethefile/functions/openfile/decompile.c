int openfile()
{
  if ( fp )
  {
    puts("You need to close the file first");
    return 0;
  }
  else
  {
    memset(magicbuf, 0, 0x190u);
    printf("What do you want to see :");
    __isoc99_scanf("%63s", filename);
    if ( strstr(filename, "flag") )
    {
      puts("Danger !");
      exit(0);
    }
    fp = fopen(filename, "r");
    if ( fp )
      return puts("Open Successful");
    else
      return puts("Open failed");
  }
}
