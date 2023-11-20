ssize_t vulnerable_function()
{
  char buf[128]; 

  return read(0, buf, 0x200uLL);
}