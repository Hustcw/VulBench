unsigned __int64 sub_11D5()
{
  unsigned __int64 v1;

  v1 = __readfsqword(0x28u);
  setbuf(stdin, 0LL);
  setbuf(stderr, 0LL);
  setbuf(stdout, 0LL);
  alarm(0x3Cu);
  return __readfsqword(0x28u) ^ v1;
}
