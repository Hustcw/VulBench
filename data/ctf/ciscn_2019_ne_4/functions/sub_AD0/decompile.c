unsigned __int64 sub_AD0()
{
  unsigned __int64 v1;

  v1 = __readfsqword(0x28u);
  setvbuf(stdin, 0LL, 2, 0LL);
  setvbuf(stdout, 0LL, 2, 0LL);
  memset(&unk_202040, 0, 0x140uLL);
  alarm(0x3Cu);
  return __readfsqword(0x28u) ^ v1;
}
