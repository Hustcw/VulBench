int get_int()
{
  char buf[10];
  unsigned __int64 v2;

  v2 = __readfsqword(0x28u);
  read(0, buf, 0xAuLL);
  return atoi(buf);
}
