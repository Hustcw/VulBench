int init_0()
{
  setvbuf(stdin, 0LL, 1, 0LL);
  setvbuf(stdout, 0LL, 2, 0LL);
  return setvbuf(stderr, 0LL, 1, 0LL);
}