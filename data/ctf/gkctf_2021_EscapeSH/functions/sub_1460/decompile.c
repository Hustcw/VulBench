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
  puts("** Please input \"\x1B[1mhelp\x1B[m\" to show what commands can you use   **");
  puts("*************************************************************");
  puts("        mmm  m    m   mmm mmmmmmm mmmmmm");
  puts("      m\"   \" #  m\"  m\"   \"   #    #     ");
  puts("      #   mm #m#    #        #    #mmmmm");
  puts("      #    # #  #m  #        #    #     ");
  puts("       \"mmm\" #   \"m  \"mmm\"   #    #     ");
  return __readfsqword(0x28u) ^ v3;
}
