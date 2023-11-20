unsigned __int64 edit()
{
  _BYTE *v0;
  unsigned int v2;
  char buf[24];
  unsigned __int64 v4;

  v4 = __readfsqword(0x28u);
  puts("What hero do you want to edit?");
  read(0, buf, 0x10uLL);
  v2 = atoi(buf);
  if ( v2 <= 9 && name[v2] )
  {
    free((void *)name[v2]);
    name[v2] = malloc(0x68uLL);
    puts("What's your hero's name:");
    v0 = (_BYTE *)name[v2];
    v0[read(0, v0, 0x68uLL)] = 0;
    free(*((void **)&power + v2));
    *((_QWORD *)&power + v2) = malloc(0xF8uLL);
    puts("What's your hero's power:");
    read(0, *((void **)&power + v2), 0xF8uLL);
    puts("Done!");
  }
  else
  {
    puts("No such hero!");
  }
  return __readfsqword(0x28u) ^ v4;
}
