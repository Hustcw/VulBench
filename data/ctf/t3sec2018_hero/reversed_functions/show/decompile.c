void show()
{
  unsigned int v0;
  char buf[24];
  unsigned __int64 v2;

  v2 = __readfsqword(0x28u);
  puts("What hero do you want to show?");
  read(0, buf, 0x10uLL);
  v0 = atoi(buf);
  if ( v0 <= 9 && name[v0] )
  {
    printf("Hero:%s\nPower:%s\n", name[v0], power[v0]);
    puts("Done!");
  }
  else
  {
    puts("No such hero!");
  }
}