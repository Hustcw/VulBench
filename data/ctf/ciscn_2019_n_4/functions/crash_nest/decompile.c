unsigned __int64 crash_nest()
{
  int v1;
  char buf[8];
  unsigned __int64 v3;

  v3 = __readfsqword(0x28u);
  printf("Index :");
  read(0, buf, 4uLL);
  v1 = atoi(buf);
  if ( (unsigned int)v1 >= 0xA )
  {
    puts("OOB!My Boy!");
    _exit(0);
  }
  if ( *(&nests + v1) )
  {
    free(*((void **)*(&nests + v1) + 1));
    free(*(&nests + v1));
    *(&nests + v1) = 0LL;
    puts("Now another w0odpeck3r lost his house :(");
  }
  else
  {
    puts("No such nest !");
  }
  return __readfsqword(0x28u) ^ v3;
}
