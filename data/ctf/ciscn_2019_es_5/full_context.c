struct Flag
{
  char *content;
  int size;
  int state;
};

Flag *flag_list[10];

void __fastcall secure_read(char *a1, unsigned int a2)
{
  int v2;

  v2 = read(0, a1, a2);
  if ( v2 < 0 )
  {
    puts("Do you want a flag?");
    exit(0);
  }
  if ( a1[v2 - 1] == 10 )
    a1[v2 - 1] = 0;
}

int read_int()
{
  char nptr[24];
  unsigned __int64 v2;

  v2 = __readfsqword(0x28u);
  secure_read(nptr, 0x10u);
  return atoi(nptr);
}

void __noreturn timeout()
{
  puts("Time out!");
  exit(0);
}

unsigned int init()
{
  setbuf(stdin, 0LL);
  setbuf(stdout, 0LL);
  setbuf(stderr, 0LL);
  signal(14, (__sighandler_t)timeout);
  return alarm(0x3Cu);
}

void menu()
{
  puts("1.Create flag");
  puts("2.Edit flag");
  puts("3.Show flag");
  puts("4.Delete flag");
  puts("5.Exit");
  printf("Your choice:");
}

void Create()
{
  int i;
  Flag *v1;

  for ( i = 0; i <= 9 && flag_list[i]; ++i )
    ;
  if ( i == 10 )
  {
    puts("Full flag!");
  }
  else
  {
    v1 = (Flag *)malloc(0x10uLL);
    printf("size?>");
    v1->size = read_int();
    v1->content = (char *)malloc(v1->size);
    if ( !v1->content )
    {
      puts("Can not malloc!");
      exit(0);
    }
    printf("content:");
    secure_read(v1->content, v1->size);
    v1->state = 1;
    flag_list[i] = v1;
    puts("OK!");
  }
}

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

int __cdecl main(int argc, const char **argv, const char **envp)
{
  init(argc, argv, envp);
  while ( 1 )
  {
    menu();
    switch ( (unsigned int)read_int() )
    {
      case 1u:
        Create();
        break;
      case 2u:
        Edit();
        break;
      case 3u:
        Show();
        break;
      case 4u:
        Delete();
        break;
      case 5u:
        exit(0);
      default:
        puts("Invalid choice!");
        break;
    }
  }
}