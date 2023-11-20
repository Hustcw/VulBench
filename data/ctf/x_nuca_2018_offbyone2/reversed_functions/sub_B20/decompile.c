void __fastcall sub_B20(char *a1, unsigned int a2)
{
  char buf;
  unsigned int i;
  unsigned __int64 v4;

  v4 = __readfsqword(0x28u);
  for ( i = 0; i < a2; ++i )
  {
    buf = 0;
    if ( read(0, &buf, 1uLL) < 0 )
    {
      puts("Read error.");
      exit(-2);
    }
    if ( buf == 10 )
    {
      a1[i] = 0;
      return;
    }
    a1[i] = buf;
  }
  a1[i] = 0;
}