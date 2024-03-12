char win1;
char win2;

void win_function1()
{
  win1 = 1;
}

int __cdecl win_function2(int a1)
{
  int result;

  result = (unsigned __int8)win1;
  if ( win1 && a1 == -1163220307 )
  {
    win2 = 1;
  }
  else if ( win1 )
  {
    return puts("Wrong Argument. Try Again.");
  }
  else
  {
    return puts("Nope. Try a little bit harder.");
  }
  return result;
}

int __cdecl flag(int a1)
{
  char s[48];
  FILE *stream;

  stream = fopen("flag.txt", "r");
  if ( !stream )
  {
    puts(
      "Flag File is Missing. Problem is Misconfigured, please contact an Admin if you are running this on the shell server.");
    exit(0);
  }
  fgets(s, 48, stream);
  if ( win1 && win2 && a1 == -559039827 )
    return printf("%s", s);
  if ( win1 && win2 )
    return puts("Incorrect Argument. Remember, you can call other functions in between each win function!");
  if ( win1 || win2 )
    return puts("Nice Try! You're Getting There!");
  return puts("You won't get the flag that easy..");
}

char *vuln()
{
  char s[24];

  printf("Enter your input> ");
  return gets(s);
}

int __cdecl main(int argc, const char **argv, const char **envp)
{
  __gid_t v4;

  setvbuf(_bss_start, 0, 2, 0);
  v4 = getegid();
  setresgid(v4, v4, v4);
  vuln();
  return 0;
}