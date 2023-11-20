unsigned int sub_A40()
{
  setbuf(stdin, 0LL);
  setbuf(stdout, 0LL);
  return alarm(0x78u);
}
