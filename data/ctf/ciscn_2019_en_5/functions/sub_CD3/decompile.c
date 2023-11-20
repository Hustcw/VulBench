int sub_CD3()
{
  char s[40];
  unsigned __int64 v2;

  v2 = __readfsqword(0x28u);
  memset(s, 0, 0x20uLL);
  read(0, s, 0xAuLL);
  return atoi(s);
}
