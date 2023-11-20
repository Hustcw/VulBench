int readint()
{
  char s[32];
  unsigned int v2;

  v2 = __readgsdword(0x14u);
  fgets(s, 32, stdin);
  return strtoll(s, 0, 10);
}