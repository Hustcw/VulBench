struct Notebook
{
  int used;
  int size;
  char title[144];
  char *content;
};

Notebook notebook[16];

__int64 __fastcall input2addr(char *a1, signed int a2)
{
  char buf;
  unsigned int i;
  unsigned __int64 v5;

  v5 = __readfsqword(0x28u);
  for ( i = 0; (int)i <= a2; ++i )
  {
    if ( read(0, &buf, 1uLL) < 0 )
      exit(1);
    a1[i] = buf;
    if ( a1[i] == 10 )
    {
      a1[i] = 0;
      return i;
    }
  }
  return i;
}

int input_choice()
{
  char s[24];
  unsigned __int64 v2;

  v2 = __readfsqword(0x28u);
  memset(s, 0, 0x10uLL);
  if ( (int)read(0, s, 0x10uLL) < 0 )
    exit(1);
  return atoi(s);
}

Notebook *welcome()
{
  Notebook *result;
  int i;

  setvbuf(stdin, 0LL, 2, 0LL);
  setvbuf(stdout, 0LL, 2, 0LL);
  fclose(stderr);
  alarm(0x3Cu);
  result = (Notebook *)write(1, "Welcome!\n", 9uLL);
  for ( i = 0; i <= 15; ++i )
  {
    result = &notebook[i];
    result->used = 0;
  }
  return result;
}

ssize_t menu()
{
  write(1, "***********************\n", 0x18uLL);
  write(1, "1.Add new note\n", 0xFuLL);
  write(1, "2.Delete a note\n", 0x10uLL);
  write(1, "3.Show a note\n", 0xEuLL);
  write(1, "4.Exit\n", 7uLL);
  write(1, "***********************\n", 0x18uLL);
  return write(1, "Your choice: ", 0xDuLL);
}

__int64 uadd()
{
  int i;
  int j;
  int v3;
  char s[264];
  unsigned __int64 v5;

  v5 = __readfsqword(0x28u);
  write(1, "please input the note size: ", 0x1CuLL);
  v3 = input_choice();
  if ( v3 > 256 )
  {
    write(1, "Stop heap abuse!!\n", 0x12uLL);
    exit(0);
  }
  for ( i = 0; i <= 15 && notebook[i].used; ++i )
    ;
  if ( i > 15 )
  {
    write(1, "Too much note!!\n", 0x10uLL);
    exit(0);
  }
  memset(notebook[i].title, 0, 0x90uLL);
  memset(s, 0, 0x100uLL);
  notebook[i].content = (char *)malloc(v3);
  write(1, "Please input the title: ", 0x18uLL);
  input2addr(s, 0x90);
  write(1, "Please input the content: ", 0x1AuLL);
  if ( read(0, notebook[i].content, v3) < 0 )
    exit(1);
  notebook[i].used = 1;
  notebook[i].size = v3;
  for ( j = 0; j <= 0x90; ++j )
  {
    notebook[i].title[j] = s[j];
    if ( !s[j] )
      break;
  }
  return 0LL;
}

ssize_t udelete()
{
  unsigned int v1;

  write(1, "Which Note do you want to delete: ", 0x22uLL);
  v1 = input_choice();
  if ( v1 >= 0x10 )
    return write(1, "Out of bound!\n", 0xEuLL);
  if ( notebook[v1].used )
  {
    free(notebook[v1].content);
    notebook[v1].used = 0;
  }
  return 0LL;
}

ssize_t ushow()
{
  unsigned int v1;
  int v2;

  write(1, "Which Note do you want to show: ", 0x20uLL);
  v1 = input_choice();
  if ( v1 >= 0x10 )
    return write(1, "Out of bound!\n", 0xEuLL);
  if ( notebook[v1].used )
  {
    write(1, "note title: ", 0xCuLL);
    v2 = strlen(notebook[v1].title);
    write(1, notebook[v1].title, v2);
    putchar('\n');
    write(1, "note content: ", 0xEuLL);
    write(1, notebook[v1].content, notebook[v1].size);
    putchar('\n');
  }
  return 0LL;
}

int __cdecl __noreturn main(int argc, const char **argv, const char **envp)
{
  int v3;
  char buf[264];
  unsigned __int64 v5;

  v5 = __readfsqword(0x28u);
  welcome(argc, argv, envp);
  while ( 1 )
  {
    menu();
    v3 = input_choice();
    if ( v3 == 2 )
    {
      udelete();
    }
    else if ( v3 > 2 )
    {
      if ( v3 == 3 )
      {
        ushow();
      }
      else if ( v3 == 4 )
      {
        exit(0);
      }
    }
    else if ( v3 == 1 )
    {
      uadd();
    }
    write(1, "REMARK: ", 8uLL);
    read(0, buf, 0x100uLL);
  }
}