__int64 sub_C10()
{
  __int64 v1[3];

  v1[0] = 0LL;
  v1[1] = __readfsqword(0x28u);
  sub_B70(v1, 8LL);
  return strtol((const char *)v1, 0LL, 10);
}
