unsigned __int64 sub_400FCB()
{
  int i;
  char s[280];
  unsigned __int64 v3;

  v3 = __readfsqword(0x28u);
  memset(s, 0, 0x10AuLL);
  for ( i = 0; i <= 15; ++i )
  {
    if ( qword_602180[i] )
    {
      snprintf(s, 0x100uLL, "%d\t->\t%lu", (unsigned int)i, qword_602180[i]);
      sub_400C00(s);
      fflush(stdout);
    }
  }
  return __readfsqword(0x28u) ^ v3;
}
