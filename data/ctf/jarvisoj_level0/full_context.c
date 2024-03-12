#include <defs.h>


int callsystem()
{
  return system("/bin/sh");
}

ssize_t vulnerable_function()
{
  char buf[128]; 

  return read(0, buf, 0x200uLL);
}

int __cdecl main(int argc, const char **argv, const char **envp)
{
  write(1, "Hello, World\n", 0xDuLL);
  return vulnerable_function();
}