
__int64 get_long()
{
  char s[8];
  unsigned __int64 v2;

  v2 = __readfsqword(0x28u);
  fgets(s, 8, stdin);
  return atol(s);
}

__int64 __fastcall read_str(int a1, char *a2, unsigned __int64 a3)
{
  unsigned __int64 v5;
  ssize_t v6;

  v5 = 0LL;
  while ( v5 < a3 )
  {
    v6 = read(a1, &a2[v5], a3 - v5);
    if ( v6 == -1 )
    {
      if ( *_errno_location() != 11 && *_errno_location() != 4 )
        return -1LL;
    }
    else
    {
      if ( !v6 )
        return v5;
      v5 += v6;
    }
  }
  return v5;
}

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