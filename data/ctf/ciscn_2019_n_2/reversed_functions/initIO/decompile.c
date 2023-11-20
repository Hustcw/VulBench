unsigned int initIO()
{
  setvbuf(stdin, 0LL, 2, 0LL);
  setvbuf(stdout, 0LL, 2, 0LL);
  setvbuf(stderr, 0LL, 2, 0LL);
  signal(14, (__sighandler_t)handler);
  return alarm(0x3Cu);
}