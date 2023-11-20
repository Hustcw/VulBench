__int64 __fastcall read_str(char *a1, int a2)
{
  int i;
  char buf[24];
  unsigned __int64 v5;

  v5 = __readfsqword(0x28u);
  for ( i = 0; i < a2; ++i )
  {
    read(0, buf, 1uLL);
    if ( buf[0] == '\n' )
      break;
    a1[i] = buf[0];
  }
  a1[i] = 0;
  return (unsigned int)i;
}