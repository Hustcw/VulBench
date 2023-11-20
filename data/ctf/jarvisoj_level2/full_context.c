#include <defs.h>
#include <defs.h>

ssize_t vulnerable_function()
{
  char buf[136]; 

  system("echo Input:");
  return read(0, buf, 0x100u);
}


int __cdecl main(int argc, const char **argv, const char **envp)
{
  vulnerable_function();
  system("echo 'Hello World!'");
  return 0;
}