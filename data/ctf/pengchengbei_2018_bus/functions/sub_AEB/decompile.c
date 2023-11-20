__sighandler_t sub_AEB()
{
  __sighandler_t result;

  setvbuf(stdin, 0LL, 2, 0LL);
  setvbuf(stderr, 0LL, 2, 0LL);
  setvbuf(stdout, 0LL, 2, 0LL);
  alarm(0x300u);
  result = signal(14, (__sighandler_t)handler);
  qword_202068 = -1LL;
  return result;
}
