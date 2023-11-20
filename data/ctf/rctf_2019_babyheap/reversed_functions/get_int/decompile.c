int get_int()
{
  char nptr[8];
  __int64 v2;
  unsigned __int64 v3;

  v3 = __readfsqword(0x28u);
  *(_QWORD *)nptr = 0LL;
  v2 = 0LL;
  read_n(nptr, 0xFu);
  return atoi(nptr);
}