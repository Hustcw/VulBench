int input_choice()
{
  char s[24];
  unsigned __int64 v2;

  v2 = __readfsqword(0x28u);
  memset(s, 0, 0x10uLL);
  if ( (int)read(0, s, 0x10uLL) < 0 )
    exit(1);
  return atoi(s);
}
