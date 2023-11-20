int read_int()
{
  char nptr[24];
  unsigned __int64 v2;

  v2 = __readfsqword(0x28u);
  secure_read(nptr, 0x10u);
  return atoi(nptr);
}