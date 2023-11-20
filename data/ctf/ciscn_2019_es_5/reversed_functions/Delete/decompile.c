void Delete()
{
  unsigned int v0;
  Flag *ptr;

  printf("Index:");
  v0 = read_int();
  if ( v0 >= 0xA )
  {
    puts("You want to steal the flag?");
    exit(0);
  }
  if ( flag_list[v0] )
  {
    ptr = flag_list[v0];
    free(ptr->content);
    ptr->content = 0LL;
    free(ptr);
    flag_list[v0] = 0LL;
    puts("OK!");
  }
  else
  {
    puts("None flag!");
  }
}