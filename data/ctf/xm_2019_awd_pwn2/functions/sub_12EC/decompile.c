int sub_12EC()
{
  char nptr[8];
  __int64 v2;
  int v3;
  unsigned __int64 v4;

  v4 = __readfsqword(0x28u);
  *(_QWORD *)nptr = 0LL;
  v2 = 0LL;
  v3 = 0;
  sub_1249((__int64)nptr, 0x10u);
  return atoi(nptr);
}
