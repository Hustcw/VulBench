unsigned __int64 show()
{
  unsigned int v1;
  char buf[24];
  unsigned __int64 v3;

  v3 = __readfsqword(0x28u);
  puts("What hero do you want to show?");
  read(0, buf, 0x10uLL);
  v1 = atoi(buf);
  if ( v1 <= 9 && name[v1] )
  {
    printf("Hero:%s\nPower:%s\n", (const char *)name[v1], *((const char **)&power + v1));
    puts("Done!");
  }
  else
  {
    puts("No such hero!");
  }
  return __readfsqword(0x28u) ^ v3;
}
