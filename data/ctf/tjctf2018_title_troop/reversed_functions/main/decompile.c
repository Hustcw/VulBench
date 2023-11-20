int __cdecl main(int argc, const char **argv, const char **envp)
{
  char *v3;
  __gid_t rgid;
  char *dest;
  __int64 v7[8];
  char *v8;
  int v9;
  unsigned __int64 v10;

  v10 = __readfsqword(0x28u);
  rgid = getegid();
  setresgid(rgid, rgid, rgid);
  setbuf(stdout, 0LL);
  v9 = 0;
  v8 = (char *)malloc(0x20uLL);
  puts("Commands:\n A <name> - Add a team member\n F - Fight the monster\n Q - Quit");
  while ( 1 )
  {
    while ( 1 )
    {
      while ( 1 )
      {
        gets(input, 255LL, stdin);
        if ( input[0] != 'A' )
          break;
        if ( v9 <= 8 )
        {
          v3 = &v8[v9];
          *v3 = rand() % 10;
          dest = (char *)malloc(0x100uLL);
          strcpy(dest, src);
          v7[v9++] = (__int64)dest;
        }
        else
        {
          puts("Your team is too large!");
        }
      }
      if ( input[0] != 'F' )
        break;
      fight(v8, v9);
    }
    if ( input[0] == 81 )
      break;
    puts("Try again");
  }
  puts("Thanks for playing!");
  return 0;
}