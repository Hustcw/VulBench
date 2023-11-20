void sub_B47()
{
  unsigned __int64 v0;
  char s[24];
  unsigned __int64 v2;

  v2 = __readfsqword(0x28u);
  puts("Which goods that you don't need?");
  fgets(s, 24, stdin);
  v0 = strtoul(s, 0LL, 0);
  if ( v0 <= qword_202090 )
    sub_AD0(v0);
  else
    puts("That goods is out of your cart.");
}