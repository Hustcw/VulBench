__int64 sub_11F0()
{
  char s[1032];
  unsigned __int64 v2;

  v2 = __readfsqword(0x28u);
  memset(s, 0, 0x400uLL);
  printf("> ");
  sub_1050(0LL, s, 1023LL);
  return (unsigned int)atoi(s);
}