unsigned int init()
{
  int fd;

  fd = open("/dev/urandom", 0);
  close(fd);
  setvbuf(_bss_start, 0LL, 2, 0LL);
  signal(14, handler);
  return alarm(0x3Cu);
}