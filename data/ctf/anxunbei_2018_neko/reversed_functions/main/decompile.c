int __cdecl main(int argc, const char **argv, const char **envp)
{
  char v4[5]; // [esp+Fh] [ebp-9h] BYREF

  setvbuf(stdout, 0, 2, 0);
  setvbuf(_bss_start, 0, 2, 0);
  __isoc99_scanf("%c", v4);
  if ( v4[0] == 'y' || v4[0] == 89 )
  {
    play();
  }
  else if ( v4[0] == 110 || v4[0] == 78 )
  {
    puts("No...there is no flag for the guy who don't like cats..");
  }
  else
  {
    puts("answer my question OK?");
  }
  return 0;
}