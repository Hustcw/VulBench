int sub_B65()
{
  char buf;
  int i;
  char nptr[24];
  unsigned __int64 v4;

  v4 = __readfsqword(0x28u);
  for ( i = 0; ; ++i )
  {
    read(0, &buf, 1uLL);
    if ( buf == 10 || i > 9 || buf == -1 )
      break;
    nptr[i] = buf;
  }
  nptr[i] = 0;
  return atoi(nptr);
}
