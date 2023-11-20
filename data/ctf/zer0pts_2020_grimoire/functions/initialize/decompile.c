unsigned __int64 initialize()
{
  unsigned __int64 v1;

  v1 = __readfsqword(0x28u);
  setbuf(stdin, 0LL);
  setbuf(stdout, 0LL);
  setbuf(stderr, 0LL);
  signal(14, handler);
  alarm(0x3Cu);
  strcpy(filepath, "grimoire.txt");
  init = 0;
  return __readfsqword(0x28u) ^ v1;
}
