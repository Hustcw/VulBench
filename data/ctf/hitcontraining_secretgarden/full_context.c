struct Flower
{
  int used;
  _BYTE gap4[4];
  char *name;
  char color[24];
};

int flowercount;
Flower *flowerlist[100];

int menu()
{
  puts("  1 . Raise a flower ");
  puts("  2 . Visit the garden ");
  puts("  3 . Remove a flower from the garden");
  puts("  4 . Clean the garden");
  puts("  5 . Leave the garden");
  return printf("Your choice : ");
}

void add()
{
  unsigned int size;
  unsigned int i;
  Flower *s;
  void *buf;

  s = 0LL;
  buf = 0LL;
  size = 0;
  if ( (unsigned int)flowercount > 0x63 )
  {
    puts("The garden is overflow");
  }
  else
  {
    s = (Flower *)malloc(0x28uLL);
    memset(s, 0, 0x28uLL);
    printf("Length of the name :");
    if ( (unsigned int)__isoc99_scanf("%u", &size) == -1 )
      exit(-1);
    buf = malloc(size);
    if ( !buf )
    {
      puts("Alloca error !!");
      exit(-1);
    }
    printf("The name of flower :");
    read(0, buf, size);
    s->name = (char *)buf;
    printf("The color of the flower :");
    __isoc99_scanf("%23s", s->color);
    s->used = 1;
    for ( i = 0; i <= 0x63; ++i )
    {
      if ( !flowerlist[i] )
      {
        flowerlist[i] = s;
        break;
      }
    }
    ++flowercount;
    puts("Successful !");
  }
}

void del()
{
  unsigned int v0;

  if ( flowercount )
  {
    printf("Which flower do you want to remove from the garden:");
    __isoc99_scanf("%d", &v0);
    if ( v0 <= 0x63 && flowerlist[v0] )
    {
      flowerlist[v0]->used = 0;
      free(flowerlist[v0]->name);
      puts("Successful");
    }
    else
    {
      puts("Invalid choice");
    }
  }
  else
  {
    puts("No flower in the garden");
  }
}

int magic()
{
  return system("/bin/sh");
}

void clean()
{
  unsigned int i;

  for ( i = 0; i <= 0x63; ++i )
  {
    if ( flowerlist[i] && !flowerlist[i]->used )
    {
      free(flowerlist[i]);
      flowerlist[i] = 0LL;
      --flowercount;
    }
  }
  puts("Done!");
}

void visit()
{
  unsigned int i;

  if ( flowercount )
  {
    for ( i = 0; i <= 0x63; ++i )
    {
      if ( flowerlist[i] )
      {
        if ( flowerlist[i]->used )
        {
          printf("Name of the flower[%u] :%s\n", i, flowerlist[i]->name);
          printf("Color of the flower[%u] :%s\n", i, flowerlist[i]->color);
        }
      }
    }
  }
  else
  {
    puts("No flower in the garden !");
  }
}

void __noreturn handler()
{
  puts("timeout");
  exit(1);
}

unsigned int init()
{
  int fd;

  fd = open("/dev/urandom", 0);
  close(fd);
  setvbuf(_bss_start, 0LL, 2, 0LL);
  signal(14, handler);
  return alarm(0x3Cu);
}

int __cdecl main(int argc, const char **argv, const char **envp)
{
  char buf[10];
  unsigned __int64 v5;

  v5 = __readfsqword(0x28u);
  init();
  while ( 1 )
  {
    menu();
    read(0, buf, 8uLL);
    switch ( atoi(buf) )
    {
      case 1:
        add();
        break;
      case 2:
        visit();
        break;
      case 3:
        del();
        break;
      case 4:
        clean();
        break;
      case 5:
        puts("See you next time.");
        exit(0);
      default:
        puts("Invalid choice");
        break;
    }
  }
}