int read_int(void)
{
  char buf[16];

  read(0, buf, 0x10uLL);
  return atoi(buf);
}