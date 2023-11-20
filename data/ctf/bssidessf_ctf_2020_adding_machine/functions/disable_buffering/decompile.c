unsigned __int64 disable_buffering()
{
  unsigned __int64 v1;

  v1 = __readfsqword(0x28u);
  setbuf(stdout, 0LL);
  setbuf(stderr, 0LL);
  return __readfsqword(0x28u) ^ v1;
}
