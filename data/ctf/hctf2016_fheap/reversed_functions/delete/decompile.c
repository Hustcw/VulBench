void delete()
{
  unsigned int v0;
  char buf[264];
  unsigned __int64 v2;

  v2 = __readfsqword(0x28u);
  printf("Pls give me the string id you want to delete\nid:");
  v0 = read_int();
  if ( v0 >= 0x11 )
    puts("Invalid id");
  if ( list[v0].content )
  {
    printf("Are you sure?:");
    read(0, buf, 0x100uLL);
    if ( !strncmp(buf, "yes", 3uLL) )
    {
      list[v0].content->free_func(list[v0].content);
      list[v0].used = 0;
    }
  }
}