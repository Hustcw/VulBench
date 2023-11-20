int read_num()
{
  char nptr[40];
  unsigned __int64 v2;

  v2 = __readfsqword(0x28u);
  read_str2(nptr, 32);
  return atoi(nptr);
}