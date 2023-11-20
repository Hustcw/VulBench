unsigned __int64 sub_1160()
{
  int fd;
  unsigned __int64 v2;

  v2 = __readfsqword(0x28u);
  fd = open("/dev/urandom", 0);
  close(fd);
  setvbuf(stdout, 0LL, 2, 0LL);
  signal(14, (__sighandler_t)handler);
  alarm(0x3Cu);
  return __readfsqword(0x28u) ^ v2;
}
