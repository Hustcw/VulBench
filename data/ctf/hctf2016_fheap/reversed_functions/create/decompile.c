void create()
{
  int i;
  Content *ptr;
  char *dest;
  size_t nbytes;
  size_t nbytesa;
  char buf[4104];
  unsigned __int64 v6;

  v6 = __readfsqword(0x28u);
  ptr = (Content *)malloc(0x20uLL);
  printf("Pls give string size:");
  nbytes = read_int();
  if ( nbytes <= 0x1000 )
  {
    printf("str:");
    if ( read(0, buf, nbytes) == -1 )
    {
      puts("got elf!!");
      exit(1);
    }
    nbytesa = strlen(buf);
    if ( nbytesa > 0xF )
    {
      dest = (char *)malloc(nbytesa);
      if ( !dest )
      {
        puts("malloc faild!");
        exit(1);
      }
      strncpy(dest, buf, nbytesa);
      ptr->content = dest;
      ptr->free_func = free2;
    }
    else
    {
      strncpy((char *)ptr, buf, nbytesa);
      ptr->free_func = free1;
    }
    ptr->size = nbytesa;
    for ( i = 0; i <= 15; ++i )
    {
      if ( !list[i].used )
      {
        list[i].used = 1;
        list[i].content = ptr;
        printf("The string id is %d\n", (unsigned int)i);
        break;
      }
    }
    if ( i == 16 )
    {
      puts("The string list is full");
      ptr->free_func(ptr);
    }
  }
  else
  {
    puts("Invalid size");
    free(ptr);
  }
}