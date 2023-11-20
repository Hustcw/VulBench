int __cdecl __noreturn main(int argc, const char **argv, const char **envp)
{
  int v3;
  int v4;

  v4 = 0;
  printf("IP: ");
  fgets(&s, 32, stdin);
  *(&s + strlen(&s) - 1) = 0;
  while ( 1 )
  {
    if ( time(0) == 1483228800 )
    {
      admin();
    }
    else
    {
      v3 = rand();
      v4 = loop((unsigned __int16)(((unsigned int)(v3 >> 31) >> 16) + v3) - ((unsigned int)(v3 >> 31) >> 16), v4);
    }
  }
}
