unsigned __int64 decoratenest()
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
    printf("what stuff you wanna put in the nest?");
    myread(*((void **)*(&nests + v1) + 1), *(_QWORD *)*(&nests + v1) + 1LL);
    puts("Done !");
  }
  else
  {
    puts("No such nest !");
  }
  return __readfsqword(0x28u) ^ v3;
}
