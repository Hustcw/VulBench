void result()
{
  int i;
  char s[280];
  unsigned __int64 v2;

  v2 = __readfsqword(0x28u);
  memset(s, 0, 0x10AuLL);
  for ( i = 0; i <= 15; ++i )
  {
    if ( vote_list[i] )
    {
      snprintf(s, 0x100uLL, "%d\t->\t%lu", (unsigned int)i, vote_list[i]);
      println(s);
      fflush(stdout);
    }
  }
}