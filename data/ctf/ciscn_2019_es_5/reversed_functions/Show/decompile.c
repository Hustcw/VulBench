void Show()
{
  unsigned int v0;
  Flag *v1;

  printf("Index:");
  v0 = read_int();
  if ( v0 >= 0xA )
  {
    puts("You want to steal the flag?");
    exit(0);
  }
  if ( flag_list[v0] )
  {
    v1 = flag_list[v0];
    if ( v1->state )
    {
      printf("Flag of index %d:\n", v0);
      printf("Content: %s\nSize: %dsState: %d\n", v1->content, (unsigned int)v1->size, (unsigned int)v1->state);
      puts("Done!");
    }
    else
    {
      puts("Dead flag!");
    }
  }
  else
  {
    puts("None flag!");
  }
}