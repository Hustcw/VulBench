void Edit()
{
  unsigned int v0;
  Flag *v1;
  char *v2;

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
      --v1->state;
      v2 = (char *)realloc(v1->content, v1->size);
      if ( v2 )
      {
        v1->content = v2;
        printf("New content:");
        secure_read(v1->content, v1->size);
        puts("OK!");
      }
      else
      {
        puts("Can not edit this flag!");
      }
    }
    else
    {
      puts("Dead!");
    }
  }
  else
  {
    puts("None flag!");
  }
}