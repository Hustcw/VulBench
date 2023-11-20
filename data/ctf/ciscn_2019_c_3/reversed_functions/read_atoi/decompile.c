int read_atoi()
{
  char s[8];
  unsigned __int64 v2;

  v2 = __readfsqword(0x28u);
  memset(s, 0, sizeof(s));
  read(0, s, 8uLL);
  return atoi(s);
}