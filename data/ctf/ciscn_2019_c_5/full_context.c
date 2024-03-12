struct Story
{
  int size;
  char *content;
};

int count;
Story stories[16];

void menu()
{
  puts("======================");
  puts("1.Add a story");
  puts("2.Edit story");
  puts("3.Show story");
  puts("4.delete a story");
  puts("5.Exit .");
  puts("======================");
  printf("Input your choice:");
}

void add()
{
  int v0;
  int size;
  unsigned __int64 v2;

  v2 = __readfsqword(0x28u);
  if ( count > 16 )
    puts("Enough!");
  puts("Please input the size of story: ");
  _isoc99_scanf("%d", &size);
  stories[count].size = size;
  v0 = count;
  stories[v0].content = (char *)malloc(size);
  puts("please inpute the story: ");
  read(0, stories[count].content, size);
  ++count;
  puts("Done!");
}

int show()
{
  return puts("You are not the king, so you can't show the story.");
}

int edit()
{
  return puts("You are not the king, so can't edit the story");
}

void delete()
{
  int v0;
  unsigned __int64 v1;

  v1 = __readfsqword(0x28u);
  puts("Please input the index:");
  _isoc99_scanf("%d", &v0);
  free(stories[v0].content);
  puts("Done!");
}

void read_main()
{
  int v0;
  char s[16];
  char buf[40];
  unsigned __int64 v3;

  v3 = __readfsqword(0x28u);
  puts("Welcome to the story kingdom.");
  puts("What's your name?");
  read(0, buf, 0x20uLL);
  _printf_chk(1LL, buf);
  puts("Please input your ID.");
  read(0, s, 8uLL);
  puts(s);
  while ( 1 )
  {
    menu();
    _isoc99_scanf("%d", &v0);
    getchar();
    switch ( v0 )
    {
      case 1:
        add();
        break;
      case 2:
        edit();
        break;
      case 3:
        show();
        break;
      case 4:
        delete();
        break;
      case 5:
        puts("Goodbye~");
        exit(0);
      default:
        puts("Wrong choice!");
        return;
    }
  }
}

__int64 __fastcall main(__int64 a1, char **a2, char **a3)
{
  init();
  read_main(a1, a2);
  return 0LL;
}