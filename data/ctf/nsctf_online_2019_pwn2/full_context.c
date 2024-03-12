int size;
char name[48];
char *ptr;

ssize_t sub_A00()
{
  setvbuf(stdin, 0LL, 2, 0LL);
  setvbuf(stderr, 0LL, 2, 0LL);
  setvbuf(stdout, 0LL, 2, 0LL);
  puts("Welcome to notebook system");
  puts("Please input your name");
  return read(0, name, 0x30uLL);
}

int menu()
{
  puts("1.Add note");
  puts("2.Delete note");
  puts("3.Show note");
  puts("4.update your name");
  puts("5.Edit note");
  return puts("6.exit");
}

void add()
{
  int v0;
  unsigned __int64 v1;

  v1 = __readfsqword(0x28u);
  v0 = 0;
  puts("Input the size");
  _isoc99_scanf("%d", &v0);
  if ( v0 <= 0 || v0 > 1023 )
  {
    puts("Size error!");
  }
  else
  {
    ptr = malloc(v0);
    memset(ptr, 0, v0);
    size = v0;
    puts("Add success");
  }
}

void delete()
{
  if ( ptr )
  {
    free(ptr);
    ptr = 0LL;
  }
  puts("Delete success");
}

void show()
{
  if ( ptr )
    puts(ptr);
}

void edit()
{
  puts("Input the note");
  if ( ptr )
    read(0, ptr, size);
}

void update()
{
  puts("Please input your name");
  read(0, name, 0x31uLL);
}

__int64 __fastcall main(__int64 a1, char **a2, char **a3)
{
  int v4;
  unsigned __int64 v5;

  v5 = __readfsqword(0x28u);
  sub_A00(a1, a2, a3);
  while ( 1 )
  {
    menu();
    _isoc99_scanf("%d", &v4);
    switch ( v4 )
    {
      case 1:
        add();
        break;
      case 2:
        delete();
        break;
      case 3:
        show();
        break;
      case 4:
        update();
        break;
      case 5:
        edit();
        break;
      case 6:
        return 0LL;
      default:
        puts("Wrong choice");
        break;
    }
  }
}