unsigned __int64 sub_BD5()
{
  _QWORD *v0;
  unsigned __int64 v2;

  v2 = __readfsqword(0x28u);
  setvbuf(stdout, 0LL, 2, 0LL);
  setvbuf(stdin, 0LL, 1, 0LL);
  setvbuf(stderr, 0LL, 1, 0LL);
  signal(14, (__sighandler_t)handler);
  alarm(0x1Eu);
  ptr = calloc(1uLL, 0x28uLL);
  v0 = ptr;
  v0[4] = calloc(1uLL, 0x50uLL);
  printf("name> ");
  sub_B41(ptr, 24);
  return __readfsqword(0x28u) ^ v2;
}
