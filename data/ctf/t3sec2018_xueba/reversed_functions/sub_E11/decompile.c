void sub_E11()
{
  char *v0;
  char buf;
  char v2;
  int v3;
  unsigned __int64 v4;

  v4 = __readfsqword(0x28u);
  if ( dword_20204C > 1 )
  {
    puts("You are really annoying!");
    exit(0);
  }
  puts("Index:");
  _isoc99_scanf("%u", &v3);
  ++dword_20204C;
  puts("Which letter do you want to change?");
  read(0, &buf, 1uLL);
  if ( strchr(notes[v3].name, buf) )
  {
    read(0, &v2, 1uLL);
    v0 = strchr(notes[v3].name, buf);
    *v0 = v2;
    puts("Done!");
  }
  else
  {
    puts("No such letter");
  }
}