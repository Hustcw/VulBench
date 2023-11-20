ssize_t vulnerable_function()
{
  char buf[136]; 

  system("echo Input:");
  return read(0, buf, 0x100u);
}