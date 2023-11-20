__int64 sub_B1A()
{
  char nptr[8];
  __int64 v2;
  unsigned __int64 v3;

  v3 = __readfsqword(0x28u);
  *(_QWORD *)nptr = 0LL;
  v2 = 0LL;
  sub_ACC(nptr, 32LL);
  return atol(nptr);
}