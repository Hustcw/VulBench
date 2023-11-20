void edit()
{
  char *v0;
  unsigned int v1;
  char buf[24];
  unsigned __int64 v3;

  v3 = __readfsqword(0x28u);
  puts("What hero do you want to edit?");
  read(0, buf, 0x10uLL);
  v1 = atoi(buf);
  if ( v1 <= 9 && name[v1] )
  {
    free(name[v1]);
    name[v1] = (char *)malloc(0x68uLL);
    puts("What's your hero's name:");
    v0 = name[v1];
    v0[read(0, v0, 0x68uLL)] = 0;
    free(power[v1]);
    power[v1] = (char *)malloc(0xF8uLL);
    puts("What's your hero's power:");
    read(0, power[v1], 0xF8uLL);
    puts("Done!");
  }
  else
  {
    puts("No such hero!");
  }
}