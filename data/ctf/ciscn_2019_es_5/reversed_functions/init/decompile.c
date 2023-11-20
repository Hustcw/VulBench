unsigned int init()
{
  setbuf(stdin, 0LL);
  setbuf(stdout, 0LL);
  setbuf(stderr, 0LL);
  signal(14, (__sighandler_t)timeout);
  return alarm(0x3Cu);
}