int main()
{
  unsigned __int64 v2;
  char s[4104];
  unsigned __int64 v4;

  v4 = __readfsqword(0x28u);
  memset(s, 0, 0x1000uLL);
  puts("Welcome to babystack 2018!");
  puts("How many bytes do you want to send?");
  v2 = get_long();
  if ( v2 <= 0x10000 )
  {
    read_str(0, s, v2);
    puts("It's time to say goodbye.");
  }
  else
  {
    puts("You are greedy!");
  }
  return 0LL;
}