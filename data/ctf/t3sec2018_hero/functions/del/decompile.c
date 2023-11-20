unsigned __int64 del()
{
  unsigned int v1;
  char buf[24];
  unsigned __int64 v3;

  v3 = __readfsqword(0x28u);
  puts("What hero do you want to remove?");
  read(0, buf, 0x10uLL);
  v1 = atoi(buf);
  if ( v1 <= 9 && name[v1] )
  {
    free((void *)name[v1]);
    free(*((void **)&power + v1));
    name[v1] = 0LL;
    *((_QWORD *)&power + v1) = 0LL;
    puts("Done!");
  }
  else
  {
    puts("No such hero!");
  }
  return __readfsqword(0x28u) ^ v3;
}
