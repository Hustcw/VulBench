__int64 sub_400906()
{
  char s[8];
  unsigned __int64 v2;

  v2 = __readfsqword(0x28u);
  fgets(s, 8, stdin);
  return atol(s);
}
