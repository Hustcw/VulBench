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