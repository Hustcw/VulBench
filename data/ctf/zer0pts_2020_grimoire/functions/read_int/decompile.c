int read_int()
{
  char nptr[8];
  unsigned __int64 v2;

  v2 = __readfsqword(0x28u);
  readline(nptr, 7);
  return atoi(nptr);
}
