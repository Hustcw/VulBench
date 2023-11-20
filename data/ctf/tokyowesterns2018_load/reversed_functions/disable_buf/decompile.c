void disable_buf()
{
  setbuf(stdin, 0LL);
  setbuf(stdout, 0LL);
}