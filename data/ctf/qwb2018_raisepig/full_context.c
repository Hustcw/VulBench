struct Pig
{
  int used;
  char *name;
  char type[24];
};

int count;
Pig *list[100];


void menu()
{
  puts("1 . Raise a pig ");
  puts("2 . Visit pigs ");
  puts("3 . Eat a pig");
  puts("4 . Eat the whole Pig Farm");
  puts("5 . Leave the Farm");
  puts(&s);
  printf("Your choice : ");
}

__int64 raise()
{
  unsigned int size;
  unsigned int size_4;
  Pig *s;
  void *buf;
  unsigned __int64 v5;

  v5 = __readfsqword(0x28u);
  s = 0LL;
  buf = 0LL;
  size = 0;
  if ( (unsigned int)count <= 0x63 )
  {
    s = (Pig *)malloc(0x28uLL);
    memset(s, 0, sizeof(Pig));
    printf("Length of the name :");
    if ( (unsigned int)_isoc99_scanf("%u", &size) == -1 )
      exit(-1);
    buf = malloc(size);
    if ( !buf )
    {
      puts("error !");
      exit(-1);
    }
    printf("The name of pig :");
    read(0, buf, size);
    s->name = (char *)buf;
    printf("The type of the pig :");
    _isoc99_scanf("%23s", s->type);
    s->used = 1;
    for ( size_4 = 0; size_4 <= 0x63; ++size_4 )
    {
      if ( !list[size_4] )
      {
        list[size_4] = s;
        break;
      }
    }
    ++count;
  }
  return 0LL;
}

__int64 eat()
{
  unsigned int v1;
  unsigned __int64 v2;

  v2 = __readfsqword(0x28u);
  if ( count )
  {
    printf("Which pig do you want to eat:");
    _isoc99_scanf("%d", &v1);
    if ( v1 > 0x63 || !list[v1] )
    {
      puts("Invalid choice");
      return 0LL;
    }
    srand(0);
    list[v1]->used = 0;
    free(list[v1]->name);
  }
  else
  {
    puts("No pig");
  }
  return 0LL;
}

void eat_farm()
{
  unsigned int i;

  for ( i = 0; i <= 0x63; ++i )
  {
    if ( list[i] && !list[i]->used )
    {
      free(list[i]);
      list[i] = 0LL;
      --count;
    }
  }
  puts("Done!");
}

__int64 visit()
{
  unsigned int i;

  if ( count )
  {
    for ( i = 0; i <= 0x63; ++i )
    {
      if ( list[i] && list[i]->used )
      {
        printf("Name[%u] :%s\n", i, list[i]->name);
        printf("Type[%u] :%s\n", i, list[i]->type);
      }
    }
  }
  else
  {
    puts("No pig in the garden !");
  }
  return 0LL;
}

void __fastcall __noreturn main(int a1, char **a2, char **a3)
{
  char buf[24];
  unsigned __int64 v4;

  v4 = __readfsqword(0x28u);
  while ( 1 )
  {
    menu();
    read(0, buf, 8uLL);
    switch ( atoi(buf) )
    {
      case 1:
        raise();
        break;
      case 2:
        visit();
        break;
      case 3:
        eat();
        break;
      case 4:
        eat_farm();
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