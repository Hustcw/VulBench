unsigned int user_init(void)
{
  setbuf(stdin, 0LL);
  setbuf(stdout, 0LL);
  setbuf(stderr, 0LL);
  return alarm(0x1Eu);
}
