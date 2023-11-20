int sub_400C90()
{
  char s[8];
  unsigned __int64 v2;

  v2 = __readfsqword(0x28u);
  memset(s, 0, sizeof(s));
  sub_400B76((__int64)s, 8uLL);
  return atoi(s);
}
