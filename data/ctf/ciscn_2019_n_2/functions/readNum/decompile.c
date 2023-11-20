__int64 readNum()
{
  char nptr[24];
  unsigned __int64 v2;

  v2 = __readfsqword(0x28u);
  myRead(nptr, 16);
  return atoll(nptr);
}
