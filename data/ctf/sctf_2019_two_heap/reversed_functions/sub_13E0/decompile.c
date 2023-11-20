__int64 sub_13E0()
{
  __int64 v1[3];

  v1[1] = __readfsqword(0x28u);
  v1[0] = 0LL;
  sub_1350(v1, 8LL);
  return strtol((const char *)v1, 0LL, 10);
}