char filename[64];
char magicbuf[416];
char name[32];
FILE *fp;
char filename[64];
char magicbuf[416];
char name[32];
FILE *fp;

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

size_t readfile()
{
  size_t result;

  memset(magicbuf, 0, 0x190u);
  if ( !fp )
    return puts("You need to open a file first");
  result = fread(magicbuf, 0x18Fu, 1u, fp);
  if ( result )
    return puts("Read Successful");
  return result;
}

int writefile()
{
  if ( strstr(filename, "flag") || strstr(magicbuf, "FLAG") || strchr(magicbuf, 125) )
  {
    puts("you can't see it");
    exit(1);
  }
  return puts(magicbuf);
}

int closefile()
{
  int result;

  if ( fp )
    result = fclose(fp);
  else
    result = puts("Nothing need to close");
  fp = 0;
  return result;
}


int __cdecl main(int argc, const char **argv, const char **envp)
{
  int result;
  char nptr[32];

  while ( 1 )
  {
    __isoc99_scanf("%s", nptr);
    switch ( atoi(nptr) )
    {
      case 1:
        openfile();
        break;
      case 2:
        readfile();
        break;
      case 3:
        writefile();
        break;
      case 4:
        closefile();
        break;
      case 5:
        printf("Leave your name :");
        __isoc99_scanf("%s", name);
        printf("Thank you %s ,see you next time\n", name);
        if ( fp )
          fclose(fp);
        exit(0);
        return result;
      default:
        puts("Invaild choice");
        exit(0);
        return result;
    }
  }
}
