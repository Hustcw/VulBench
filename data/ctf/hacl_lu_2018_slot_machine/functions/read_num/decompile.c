__int64 read_num()
{
  char s[40];
  unsigned __int64 v2;

  v2 = __readfsqword(0x28u);
  fgets(s, 32, stdin);
  return atol(s);
}
