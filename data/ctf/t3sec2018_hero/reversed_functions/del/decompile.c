void del()
{
  unsigned int v0;
  char buf[24];
  unsigned __int64 v2;

  v2 = __readfsqword(0x28u);
  puts("What hero do you want to remove?");
  read(0, buf, 0x10uLL);
  v0 = atoi(buf);
  if ( v0 <= 9 && name[v0] )
  {
    free(name[v0]);
    free(power[v0]);
    name[v0] = 0LL;
    power[v0] = 0LL;
    puts("Done!");
  }
  else
  {
    puts("No such hero!");
  }
}