unsigned __int64 sub_400A9B()
{
  char s[8];
  unsigned __int64 v2;

  v2 = __readfsqword(0x28u);
  puts("This is a really powerful weapon...(to leak the secret code I think?)");
  memset(s, 0, sizeof(s));
  read(0, s, 2uLL);
  printf(s, 1LL);
  return __readfsqword(0x28u) ^ v2;
}
