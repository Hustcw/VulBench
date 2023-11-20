int __cdecl getNumber()
{
  char buf[16];

  getContent(buf, 16);
  return atoi(buf);
}
