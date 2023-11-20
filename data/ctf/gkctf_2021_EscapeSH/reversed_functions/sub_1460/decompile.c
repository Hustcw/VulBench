unsigned __int64 sub_1460()
{
  char *v0;
  struct utsname v2;
  unsigned __int64 v3;

  v3 = __readfsqword(0x28u);
  if ( !getcwd(path, 0x300uLL) )
  {
    puts("get path_name error");
    exit(-1);
  }
  if ( uname(&v2) )
  {
    perror("uname");
    exit(1);
  }
  putchar(10);
  _printf_chk(1LL, "Welcome to %s\n", v2.version);
  putchar(10);
  puts("*************************************************************");
  v0 = getlogin();
  _printf_chk(1LL, "** Welcome to %s Y's shell                             **\n", v0);
  return __readfsqword(0x28u) ^ v3;
}