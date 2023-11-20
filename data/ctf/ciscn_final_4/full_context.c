int note_size[32];
char *note[32];
int note_size[32];
char *note[32];


void new()
{
  unsigned int v0;
  int i;
  unsigned __int64 v2;

  v2 = __readfsqword(0x28u);
  for ( i = 0; i <= 31 && note[i]; ++i )
    ;
  if ( i == 32 )
  {
    puts("full!");
  }
  else
  {
    puts("size?");
    _isoc99_scanf("%d", &v0);
    if ( v0 < 0x1001 )
    {
      note[i] = (char *)malloc((int)v0);
      note_size[i] = v0;
      puts("content?");
      read(0, note[i], (int)v0);
    }
    else
    {
      puts("invalid size");
    }
  }
}

void delete()
{
  unsigned int v0;
  unsigned __int64 v1;

  v1 = __readfsqword(0x28u);
  puts("please don't patch this function!! I will check it!!");
  puts("index ?");
  _isoc99_scanf("%d", &v0);
  if ( v0 <= 0x1F && note[v0] )
    free(note[v0]);
  else
    puts("invalid index");
}

void mwrite()
{
  unsigned int v0;
  unsigned __int64 v1;

  v1 = __readfsqword(0x28u);
  puts("index ?");
  _isoc99_scanf("%d", &v0);
  if ( v0 <= 0x1F && note[v0] )
    puts(note[v0]);
  else
    puts("invalid index");
}

ssize_t menu()
{
  puts("--------------------");
  puts("------- note -------");
  puts("--------------------");
  puts("1. new");
  puts("2. delete");
  puts("3. write");
  puts("4. exit");
  return write(1, ">> ", 3uLL);
}


int __cdecl __noreturn main(int argc, const char **argv, const char **envp)
{
  __pid_t v3;
  int v4;
  __pid_t v5;
  char s[264];
  unsigned __int64 v7;

  v7 = __readfsqword(0x28u);
  puts("and bewared!, something is watching you !!");
  memset(s, 0, 0x100uLL);
  puts("what is your name? ");
  read(0, s, 0xFFuLL);
  printf("hi ! %s\n", s);
  while ( 1 )
  {
    while ( 1 )
    {
      menu();
      _isoc99_scanf("%d", &v4);
      if ( v4 != 2 )
        break;
      delete();
    }
    if ( v4 > 2 )
    {
      if ( v4 == 3 )
      {
        mwrite();
      }
      else
      {
        if ( v4 == 4 )
          exit(0);
LABEL_17:
        puts("Invalid choice!");
      }
    }
    else
    {
      if ( v4 != 1 )
        goto LABEL_17;
      new();
    }
  }
}
