char edit_times;
char magic_times;
char delete_times;
char add_times[4];
char *note_ptr[3];

char edit_times;
char magic_times;
char delete_times;
char add_times[4];
char *note_ptr[3];

void __cdecl add()
{
  int sz_choice;
  int i;
  int sz;
  unsigned __int64 v3;

  v3 = __readfsqword(0x28u);
  for ( i = 0; i <= 2 && note_ptr[i]; ++i )
    ;
  if ( i == 3 )
  {
    puts("Error: can not add any more");
  }
  else
  {
    puts("add size: ");
    puts("1. 0x20");
    puts("2. 0x400");
    sz = 0;
    sz_choice = 0;
    __isoc99_scanf("%d", &sz_choice);
    if ( sz_choice == 1 )
      sz = 96;
    else
      sz = 1024;
    if ( sz == 1024 )
    {
      if ( add_times[0] )
      {
        puts("Error: just can malloc chunk whose size is 0x400 once");
        exit(0);
      }
      ++add_times[0];
    }
    note_ptr[i] = (char *)malloc(sz);
    memset(note_ptr[i], 0, 0x10uLL);
    puts("content: ");
    read(0, note_ptr[i], (unsigned int)sz);
    puts("success");
  }
}

void __cdecl edit()
{
  int i;
  size_t size;
  unsigned __int64 v2;

  v2 = __readfsqword(0x28u);
  if ( edit_times == 2 )
  {
    puts("can not edit any more");
  }
  else
  {
    puts("index: ");
    i = 0;
    size = 0LL;
    __isoc99_scanf("%d", &i);
    if ( (unsigned int)i <= 2 && note_ptr[i] )
    {
      size = *((_QWORD *)note_ptr[i] - 1) & 0xFFFFFFFFFFFFFFE8LL;
      puts("content: ");
      read(0, note_ptr[i], size);
      ++edit_times;
    }
    else
    {
      puts("Error");
    }
  }
  puts("success");
}

void __cdecl show()
{
  int i;
  unsigned __int64 v1;

  v1 = __readfsqword(0x28u);
  puts("index: ");
  i = 0;
  __isoc99_scanf("%d", &i);
  if ( (unsigned int)i <= 2 && note_ptr[i] )
  {
    puts("content: ");
    puts(note_ptr[i]);
  }
  else
  {
    puts("Error");
  }
  puts("success");
}

void __cdecl myfree(char *ptr)
{
  size_t size;

  size = *((_QWORD *)ptr - 1);
  free(ptr);
  if ( size > 0x90 && (*(_QWORD *)&ptr[(size & 0xFFFFFFFFFFFFFFF8LL) - 8] & 1) != 0 )
  {
    puts("Down");
    exit(0);
  }
  puts("success");
}

void __cdecl del()
{
  int i;
  unsigned __int64 v1;

  v1 = __readfsqword(0x28u);
  puts("index: ");
  i = 0;
  __isoc99_scanf("%d", &i);
  if ( (unsigned int)i <= 2 && note_ptr[i] )
  {
    if ( delete_times == 1 )
    {
      puts("Warning: delete too often.");
      puts("please note that why and when you delete these information");
      edit();
      puts("Warning: something changed when delete the information");
      puts("Warning: you can not edit any more");
      edit_times = 2;
    }
    myfree(note_ptr[i]);
    note_ptr[i] = 0LL;
    ++delete_times;
  }
  else
  {
    puts("Error");
  }
}

void __cdecl magic()
{
  size_t addr[2];

  addr[1] = __readfsqword(0x28u);
  if ( magic_times )
  {
    puts("no magic any more!");
  }
  else
  {
    puts("addr: ");
    __isoc99_scanf("%llu", addr);
    *(_QWORD *)addr[0] = 8193LL;
  }
  puts("success");
}

int __cdecl __noreturn main(int argc, const char **argv, const char **envp)
{
  int i;

  while ( 1 )
  {
    while ( 1 )
    {
      while ( 1 )
      {
        __isoc99_scanf("%d", &i);
        if ( i != 3 )
          break;
        show();
      }
      if ( i > 3 )
        break;
      if ( i == 1 )
      {
        add();
      }
      else
      {
        if ( i != 2 )
          goto LABEL_15;
        edit();
      }
    }
    if ( i == 4 )
    {
      del();
    }
    else
    {
      if ( i != 666 )
LABEL_15:
        exit(0);
      magic();
    }
  }
}
