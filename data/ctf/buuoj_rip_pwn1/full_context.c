#include <defs.h>

int __cdecl main(int argc, const char **argv, const char **envp)
{
  char s[15]; 

  puts("please input");
  gets(s, argv);
  puts(s);
  puts("ok,bye!!!");
  return 0;
}

int fun()
{
  return system("/bin/sh");
}