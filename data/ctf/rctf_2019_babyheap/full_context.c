struct Heap
{
  char *content;
  int size;
};

Heap *ptrs;

int __cdecl main(int argc, const char **argv, const char **envp)
{
  while ( 1 )
  {
    menu();
    switch ( get_int() )
    {
      case 1:
        add();
        break;
      case 2:
        edit();
        break;
      case 3:
        delete();
        break;
      case 4:
        show();
        break;
      case 5:
        puts("See you next time!");
        exit(0);
      default:
        puts("Invalid choice!");
        break;
    }
  }
}

unsigned __int64 menu()
{
  unsigned __int64 v1;

  v1 = __readfsqword(0x28u);
  puts("1. add     ");
  puts("2. edit    ");
  puts("3. delete  ");
  puts("4. show    ");
  puts("5. exit    ");
  puts("Choice: ");
  return __readfsqword(0x28u) ^ v1;
}

int get_int()
{
  char nptr[8];
  __int64 v2;
  unsigned __int64 v3;

  v3 = __readfsqword(0x28u);
  *(_QWORD *)nptr = 0LL;
  v2 = 0LL;
  read_n(nptr, 0xFu);
  return atoi(nptr);
}

void __noreturn timeout_handler()
{
  puts("Timeout");
  exit(0);
}

__int64 __fastcall read_n(char *a1, unsigned int a2)
{
  int v3;

  v3 = read(0, a1, a2);
  if ( v3 < 0 )
  {
    puts("read() error");
    exit(0);
  }
  if ( v3 && a1[v3 - 1] == 10 )
    a1[v3 - 1] = 0;
  return (unsigned int)v3;
}

void add()
{
  Heap *v0;
  int i;
  int v2;

  for ( i = 0; ptrs[i].content && i <= 15; ++i )
    ;
  if ( i == 16 )
  {
    puts("You can't");
    exit(-1);
  }
  printf("Size: ");
  v2 = get_int();
  if ( v2 <= 0 || v2 > 4096 )
  {
    puts("Invalid size :(");
  }
  else
  {
    ptrs[i].size = v2;
    v0 = &ptrs[i];
    v0->content = (__int64)calloc(v2, 1uLL);
    puts("Add success :)");
  }
}

void edit()
{
  unsigned int v0;

  printf("Index: ");
  v0 = get_int();
  if ( v0 <= 0xF && ptrs[v0].content )
  {
    printf("Content: ");
    ptrs[v0].content[(int)read_n(ptrs[v0].content, (unsigned int)ptrs[v0].size)] = 0;
    puts("Edit success :)");
  }
  else
  {
    puts("Invalid index :(");
  }
}

void delete()
{
  unsigned int v0;

  printf("Index: ");
  v0 = get_int();
  if ( v0 <= 0xF && ptrs[v0].content )
  {
    free(ptrs[v0].content);
    ptrs[v0].content = 0LL;
    ptrs[v0].size = 0;
    puts("Delete success :)");
  }
  else
  {
    puts("Invalid index :(");
  }
}

void show()
{
  unsigned int v0;

  printf("Index: ");
  v0 = get_int();
  if ( v0 <= 0xF && ptrs[v0].content )
    puts(ptrs[v0].content);
  else
    puts("Invalid index :(");
}