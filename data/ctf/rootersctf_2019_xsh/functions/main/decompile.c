int __cdecl __noreturn main(int argc, const char **argv, const char **envp)
{
  char s[296];
  char buf[296];
  unsigned int v5;
  int *p_argc;

  p_argc = &argc;
  v5 = __readgsdword(0x14u);
  setvbuf(stdout, 0, 2, 0);
  while ( getcwd(buf, 0x64u) )
  {
    printf("\x1B[1;31m[xsh]\x1B[0m-\x1B[0;34m[%s]\x1B[0;32m$ ", buf);
    fgets(s, 296, stdin);
    fflush(stdout);
    run((int)s);
  }
  puts("BYE");
  exit(1);
}
