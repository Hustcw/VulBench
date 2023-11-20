_QWORD size[12];
char *chunk[10];

_QWORD size[12];
char *chunk[10];

int __cdecl __noreturn main(int argc, const char **argv, const char **envp)
{
  int v3;
  unsigned __int64 v4;

  v4 = __readfsqword(0x28u);
  init();
  while ( 1 )
  {
    while ( 1 )
    {
      menu();
      _isoc99_scanf("%d", &v3);
      if ( v3 != 1 )
        break;
      add();
    }
    switch ( v3 )
    {
      case 3:
        delete();
        break;
      case 2:
        show();
        break;
      case 4:
        edit();
        break;
      case 5:
        puts("See you tomorrow~");
        exit(0);
      default:
        puts("Invalid choice!");
        break;
    }
  }
}

void *init()
{
  setvbuf(stdin, 0LL, 2, 0LL);
  setvbuf(stdout, 0LL, 2, 0LL);
  setvbuf(stderr, 0LL, 2, 0LL);
  return memset(chunk, 0, sizeof(chunk));
}

void add()
{
  unsigned int v0;
  unsigned int v1;
  unsigned int v2;
  unsigned __int64 v3;

  v3 = __readfsqword(0x28u);
  printf("Give me a book ID: ");
  _isoc99_scanf("%d", &v1);
  printf("how long: ");
  _isoc99_scanf("%d", &v0);
  if ( v1 <= 9 && number <= 10 )
  {
    if ( v0 > 0xFF )
    {
      puts("too large!");
    }
    else
    {
      v2 = v1;
      chunk[v2] = (char *)malloc((int)v0);
      size[v2] = (int)v0;
      ++number;
      puts("Done!\n");
    }
  }
}

void delete()
{
  int v0;
  int v1;
  unsigned __int64 v2;

  v2 = __readfsqword(0x28u);
  v0 = 0;
  puts("Which one to throw?");
  _isoc99_scanf("%d", &v0);
  if ( (unsigned int)v0 < 0xB )
  {
    free(chunk[v0]);
    chunk[v0] = 0LL;
    --number;
    puts("Done!\n");
  }
  else
  {
    v1 = puts("Wrong!\n");
  }
}

void show()
{
  char nptr;
  int v1;
  unsigned __int64 v2;

  v2 = __readfsqword(0x28u);
  printf("Which book do you want to show?");
  read_str(&nptr, 16);
  v1 = atoi(&nptr);
  printf("Content: %s", chunk[v1]);
}

void edit()
{
  int v0;
  unsigned __int64 v1;

  v1 = __readfsqword(0x28u);
  printf("Which book to write?");
  _isoc99_scanf("%d", &v0);
  printf("Content: ");
  read_str(chunk[v0], size[v0]);
  puts("Done!\n");
}

__int64 __fastcall read_str(char *a1, int a2)
{
  int i;
  char buf[24];
  unsigned __int64 v5;

  v5 = __readfsqword(0x28u);
  for ( i = 0; i < a2; ++i )
  {
    read(0, buf, 1uLL);
    if ( buf[0] == '\n' )
      break;
    a1[i] = buf[0];
  }
  a1[i] = 0;
  return (unsigned int)i;
}

int menu()
{
  puts("\n***********************");
  puts("Welcome to the magic book world!");
  puts("***********************");
  puts("1.create a book");
  puts("2.show the content");
  puts("3.throw a book");
  puts("4.write something on the book");
  puts("5.exit the world");
  return printf("Your choice: ");
}
