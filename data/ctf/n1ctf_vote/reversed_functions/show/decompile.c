void show()
{
  unsigned int v0;
  char s[280];
  unsigned __int64 v2;

  v2 = __readfsqword(0x28u);
  memset(s, 0, 0x10AuLL);
  print("Please enter the index: ");
  v0 = read_int();
  if ( v0 <= 0xF )
  {
    if ( ptr[v0] )
    {
      snprintf(s, 0x100uLL, "name: %s\ncount: %lu\ntime: %lu", ptr[v0]->name, ptr[v0]->count, ptr[v0]->time);
      println(s);
    }
  }
}