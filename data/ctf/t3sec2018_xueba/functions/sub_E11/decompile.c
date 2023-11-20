unsigned __int64 sub_E11()
{
  char *v0;
  char buf;
  char v3;
  unsigned int v4;
  unsigned __int64 v5;

  v5 = __readfsqword(0x28u);
  if ( dword_20204C > 1 )
  {
    puts("You are really annoying!");
    exit(0);
  }
  puts("Index:");
  _isoc99_scanf("%u", &v4);
  ++dword_20204C;
  puts("Which letter do you want to change?");
  read(0, &buf, 1uLL);
  if ( strchr((const char *)&unk_202060 + 32 * v4, buf) )
  {
    read(0, &v3, 1uLL);
    v0 = strchr((const char *)&unk_202060 + 32 * v4, buf);
    *v0 = v3;
    puts("Done!");
  }
  else
  {
    puts("No such letter");
  }
  return __readfsqword(0x28u) ^ v5;
}
