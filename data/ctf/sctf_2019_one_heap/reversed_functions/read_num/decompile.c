__int64 read_num()
{
  char v1[8];
  unsigned __int64 v2;

  *(_QWORD *)v1 = 0LL;
  v2 = __readfsqword(0x28u);
  read_str(v1, 8LL);
  return strtol(v1, 0LL, 10);
}