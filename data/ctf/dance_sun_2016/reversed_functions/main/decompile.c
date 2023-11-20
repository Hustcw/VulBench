int __cdecl main(int argc, const char **argv, const char **envp)
{
  char *v4;
  char s[80];
  int v6;
  int v7;
  int v8;

  v8 = 0;
  v7 = 0;
  v6 = 0;
  memset(s, 0, sizeof(s));
  v7 = 313371337;
  printf(
    "welcome to the pro club. you just paid a door fee and have no respect. earn ur cred on the dancefloor!\n"
    "give us ur sick dance moves like so:\n"
    "whip,naenae,whip,whip,naenae<ENTER>\n");
  fflush(stdout);
  v4 = s;
  fgets(s, 89, _bss_start);
  while ( strlen(v4) )
  {
    if ( *v4 == 119 )
    {
      v4 += 5;
      printf("do the whip!\n");
      fflush(stdout);
      usleep(0xC3500u);
      do_whip();
      fflush(stdout);
      usleep(0x7A120u);
    }
    else if ( *v4 == 110 )
    {
      v4 += 7;
      printf("do the naenae\n");
      fflush(stdout);
      usleep(0x7A120u);
      do_naenae();
      fflush(stdout);
    }
    else
    {
      ++v4;
    }
  }
  if ( v7 == 313371337 )
  {
    if ( v6 )
    {
      printf("girl u can dance w the best of em. the pw to our vip lounge is: this-is-the-flag-on-srv\n");
      fflush(stdout);
    }
  }
  else
  {
    printf("those dance moves are some dark artsz kid\n");
    fflush(stdout);
  }
  printf("\ncool dance! come again!\n");
  fflush(stdout);
  return 0;
}