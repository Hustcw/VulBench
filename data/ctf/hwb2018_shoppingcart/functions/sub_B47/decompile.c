unsigned __int64 sub_B47()
{
  unsigned __int64 v1;
  char s[24];
  unsigned __int64 v3;

  v3 = __readfsqword(0x28u);
  puts("Which goods that you don't need?");
  fgets(s, 24, stdin);
  v1 = strtoul(s, 0LL, 0);
  if ( v1 <= qword_202090 )
    sub_AD0(v1);
  else
    puts("That goods is out of your cart.");
  return __readfsqword(0x28u) ^ v3;
}
