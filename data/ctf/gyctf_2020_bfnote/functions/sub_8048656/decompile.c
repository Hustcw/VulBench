int sub_8048656()
{
  char buf[8];
  unsigned int v2;

  v2 = __readgsdword(0x14u);
  read(0, buf, 8u);
  return atol(buf);
}
