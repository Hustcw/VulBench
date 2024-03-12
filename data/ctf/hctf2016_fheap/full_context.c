struct Content
{
  char *content;
  __attribute__((aligned(16))) int size;
  void (__fastcall *free_func)(Content *);
};

struct String
{
  int used;
  int field_4;
  Content *content;
};


String list[16];

int read_int()
{
  char buf;
  int i;
  char nptr[24];
  unsigned __int64 v4;

  v4 = __readfsqword(0x28u);
  for ( i = 0; ; ++i )
  {
    read(0, &buf, 1uLL);
    if ( buf == 10 || i > 9 || buf == -1 )
      break;
    nptr[i] = buf;
  }
  nptr[i] = 0;
  return atoi(nptr);
}

__int64 __fastcall main(int a1, char **a2, char **a3)
{
  char buf[1032];
  unsigned __int64 v5;

  v5 = __readfsqword(0x28u);
  setbuf(stdout, 0LL);
  setbuf(stdin, 0LL);
  setbuf(stderr, 0LL);
  puts("+++++++++++++++++++++++++++");
  puts("So, let's crash the world");
  puts("+++++++++++++++++++++++++++");
  while ( 1 )
  {
    while ( 1 )
    {
      while ( 1 )
      {
        menu();
        if ( !read(0, buf, 0x400uLL) )
          return 1LL;
        if ( strncmp(buf, "create ", 7uLL) )
          break;
        create();
      }
      if ( strncmp(buf, "delete ", 7uLL) )
        break;
      delete();
    }
    if ( !strncmp(buf, "quit ", 5uLL) )
      break;
    puts("Invalid cmd");
  }
  puts("Bye~");
  return 0LL;
}

void __fastcall free1(Content *a1)
{
  free(a1);
}

void __fastcall free2(Content *a1)
{
  free(a1->content);
  free(a1);
}

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

int _Z18wxDeleteStockListsv(void)
{
  puts("1.create string");
  puts("2.delete string");
  return puts("3.quit");
}