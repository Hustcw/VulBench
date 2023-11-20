void __fastcall main(int a1, char **a2, char **a3)
{
  s2 = (char *)malloc(0x20uLL);
  signal(14, (__sighandler_t)handler);
  alarm(0x28u);
  sub_40128B();
  if ( *((_DWORD *)s2 + 8) != 7955827 )
    exit(0);
  puts("Welcome to wat-sql!");
  puts("This project was made as an extention to the super successful project, sabataD!");
  puts("Valid queries are read, write. You are only allowed to access /home/ctf/database.txt!");
  sub_40115F();
}
