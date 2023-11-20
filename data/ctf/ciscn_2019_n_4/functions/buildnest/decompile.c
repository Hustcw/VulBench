unsigned __int64 buildnest()
{
  __int64 v0;
  int i;
  size_t size;
  char buf[8];
  unsigned __int64 v5;

  v5 = __readfsqword(0x28u);
  for ( i = 0; i <= 9; ++i )
  {
    if ( !*(&nests + i) )
    {
      *(&nests + i) = malloc(0x10uLL);
      if ( !*(&nests + i) )
      {
        puts("Nope.something wrong..");
        exit(1);
      }
      printf("how big is the nest ?");
      read(0, buf, 8uLL);
      size = atoi(buf);
      v0 = (__int64)*(&nests + i);
      *(_QWORD *)(v0 + 8) = malloc(size);
      if ( !*((_QWORD *)*(&nests + i) + 1) )
      {
        puts("Nope.something wrong..");
        exit(2);
      }
      *(_QWORD *)*(&nests + i) = size;
      printf("what stuff you wanna put in the nest?");
      myread(*((void **)*(&nests + i) + 1), size);
      puts("Thx buddy.");
      return __readfsqword(0x28u) ^ v5;
    }
  }
  return __readfsqword(0x28u) ^ v5;
}
