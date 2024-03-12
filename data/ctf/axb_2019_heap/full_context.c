struct Note
{
  __int64 content;
  int size;
  int field_C;
};

int counts;
int key;
Note note[10];

unsigned __int64 banner()
{
  char format[12];
  unsigned __int64 v2;

  v2 = __readfsqword(0x28u);
  puts("Welcome to note management system!");
  printf("Enter your name: ");
  __isoc99_scanf("%s", format);
  printf("Hello, ");
  printf(format);
  puts("\n-------------------------------------");
  return __readfsqword(0x28u) ^ v2;
}

int menu()
{
  puts("1. add note");
  puts("2. dele note");
  puts("3. show note's content");
  puts("4. edit note");
  puts("Enter a option: ");
  return printf(">> ");
}

int get_int()
{
  char buf[10];
  unsigned __int64 v2;

  v2 = __readfsqword(0x28u);
  read(0, buf, 0xAuLL);
  return atoi(buf);
}

void __fastcall get_input(char *a1, int a2)
{
  int v2; // [rsp+10h] [rbp-10h]
  char *v3; // [rsp+18h] [rbp-8h]

  v2 = 0;
  while ( 1 )
  {
    v3 = &a1[v2];
    if ( (int)fread(v3, 1uLL, 1uLL, stdin) <= 0 )
      break;
    if ( *v3 == 10 )
    {
      if ( v2 )
      {
        *v3 = 0;
        return;
      }
    }
    else if ( a2 + 1 <= (unsigned int)++v2 )
    {
      return;
    }
  }
}

_BOOL8 __fastcall check_pass(_QWORD *a1)
{
  return *a1 - (_QWORD)a1 > 4096LL;
}

unsigned __int64 add_note()
{
  unsigned int v0;
  unsigned int v1;
  unsigned int size;
  unsigned int size_4;
  unsigned __int64 v5;

  v5 = __readfsqword(0x28u);
  printf("Enter the index you want to create (0-10):");
  __isoc99_scanf("%d", &size_4);
  if ( size_4 < 0xB )
  {
    if ( counts > 0xAu )
    {
      puts("full!");
      exit(0);
    }
    puts("Enter a size:");
    __isoc99_scanf("%d", &size);
    if ( key == 43 )
    {
      puts("Enter the content: ");
      v0 = size_4;
      note[v0].content = (__int64)malloc(size);
      note[size_4].size = size;
      if ( !note[size_4].content )
      {
        fwrite("error", 1uLL, 5uLL, stderr);
        exit(0);
      }
    }
    else
    {
      if ( size <= 0x80 )
      {
        puts("You can't hack me!");
        return __readfsqword(0x28u) ^ v5;
      }
      puts("Enter the content: ");
      v1 = size_4;
      note[v1].content = (__int64)malloc(size);
      note[size_4].size = size;
      if ( !note[size_4].content )
      {
        fwrite("error", 1uLL, 5uLL, stderr);
        exit(0);
      }
    }
    if ( !(unsigned int)check_pass(&note[size_4]) )
    {
      puts("go out!hacker!");
      exit(0);
    }
    get_input(note[size_4].content, size);
    ++counts;
    puts("Done!");
  }
  else
  {
    puts("You can't hack me!");
  }
  return __readfsqword(0x28u) ^ v5;
}

unsigned __int64 delete_note()
{
  unsigned int v1;
  unsigned __int64 v2;

  v2 = __readfsqword(0x28u);
  puts("Enter an index:");
  __isoc99_scanf("%d", &v1);
  if ( v1 <= 0xA && note[v1].content )
  {
    free((void *)note[v1].content);
    note[v1].content = 0LL;
    note[v1].size = 0;
    --counts;
    puts("Done!");
  }
  else
  {
    puts("You can't hack me!");
  }
  return __readfsqword(0x28u) ^ v2;
}

unsigned __int64 edit_note()
{
  unsigned int v1;
  unsigned __int64 v2;

  v2 = __readfsqword(0x28u);
  puts("Enter an index:");
  __isoc99_scanf("%d", &v1);
  if ( v1 <= 0xA && note[v1].content )
  {
    puts("Enter the content: ");
    get_input(note[v1].content, (unsigned int)note[v1].size);
    puts("Done!");
  }
  else
  {
    puts("You can't hack me!");
  }
  return __readfsqword(0x28u) ^ v2;
}

int __cdecl __noreturn main(int argc, const char **argv, const char **envp)
{
  int v3;

  banner();
  while ( 1 )
  {
    menu();
    v3 = get_int();
    switch ( v3 )
    {
      case 1:
        add_note();
        break;
      case 2:
        delete_note();
        break;
      case 3:
        puts("None!");
        break;
      case 4:
        edit_note();
        break;
      default:
        puts("No such choices!");
        break;
    }
  }
}