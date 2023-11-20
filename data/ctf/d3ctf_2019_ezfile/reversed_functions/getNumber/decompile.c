int __cdecl getNumber()
{
  char buf[16]; // [rsp+0h] [rbp-10h] BYREF

  getContent(buf, 16);
  return atoi(buf);
}