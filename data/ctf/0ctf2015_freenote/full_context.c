struct Note
{
  __int64 used;
  __int64 field_8;
  char *content;
};

struct NoteList
{
  __int64 limit;
  __int64 count;
  Note note_list[256];
};

NoteList *note_stru;
struct Note
{
  __int64 used;
  __int64 field_8;
  char *content;
};

struct NoteList
{
  __int64 limit;
  __int64 count;
  Note note_list[256];
};

NoteList *note_stru;

__int64 __fastcall read_str(char *a1, int a2)
{
  int i;
  int v4;

  if ( a2 <= 0 )
    return 0LL;
  for ( i = 0; i < a2; i += v4 )
  {
    v4 = read(0, &a1[i], a2 - i);
    if ( v4 <= 0 )
      break;
  }
  return (unsigned int)i;
}

__int64 __fastcall read_str2(char *a1, int a2)
{
  unsigned int i;

  if ( a2 <= 0 )
    return 0LL;
  for ( i = 0; a2 - 1 > (int)i && (int)read(0, &a1[i], 1uLL) > 0 && a1[i] != 10; ++i )
    ;
  a1[i] = 0;
  return i;
}

int read_num()
{
  char nptr[40];
  unsigned __int64 v2;

  v2 = __readfsqword(0x28u);
  read_str2(nptr, 32);
  return atoi(nptr);
}

int menu_and_read_choice()
{
  puts("== 0ops Free Note ==");
  puts("1. List Note");
  puts("2. New Note");
  puts("3. Edit Note");
  puts("4. Delete Note");
  puts("5. Exit");
  puts("====================");
  printf("Your choice: ");
  return read_num();
}

void init()
{
  setvbuf(stdin, 0LL, 2, 0LL);
  setvbuf(stdout, 0LL, 2, 0LL);
  alarm(0x3Cu);
}

void init2()
{
  int i;

  note_stru = (NoteList *)malloc(0x1810uLL);
  note_stru->limit = 256LL;
  note_stru->count = 0LL;
  for ( i = 0; i <= 255; ++i )
  {
    note_stru->note_list[i].used = 0LL;
    note_stru->note_list[i].field_8 = 0LL;
    note_stru->note_list[i].content = 0LL;
  }
}

void list()
{
  unsigned int i;

  if ( note_stru->count <= 0 )
  {
    puts("You need to create some new notes first.");
  }
  else
  {
    for ( i = 0; (int)i < note_stru->limit; ++i )
    {
      if ( note_stru->note_list[i].used == 1 )
        printf("%d. %s\n", i, note_stru->note_list[i].content);
    }
  }
}

void new()
{
  int i;
  int num;
  char *v2;

  if ( note_stru->count < note_stru->limit )
  {
    for ( i = 0; i < note_stru->limit; ++i )
    {
      if ( !note_stru->note_list[i].used )
      {
        printf("Length of new note: ");
        num = read_num();
        if ( num > 0 )
        {
          if ( num > 4096 )
            num = 4096;
          v2 = (char *)malloc((128 - num % 128) % 128 + num);
          printf("Enter your note: ");
          read_str(v2, num);
          note_stru->note_list[i].used = 1LL;
          note_stru->note_list[i].field_8 = num;
          note_stru->note_list[i].content = v2;
          ++note_stru->count;
          puts("Done.");
        }
        else
        {
          puts("Invalid length!");
        }
        return;
      }
    }
  }
  else
  {
    puts("Unable to create new note.");
  }
}

void edit()
{
  NoteList *v0;
  int length;
  int num;

  printf("Note number: ");
  num = read_num();
  if ( num >= 0 && num < note_stru->limit && note_stru->note_list[num].used == 1 )
  {
    printf("Length of note: ");
    length = read_num();
    if ( length > 0 )
    {
      if ( length > 4096 )
        length = 4096;
      if ( length != note_stru->note_list[num].field_8 )
      {
        v0 = note_stru;
        v0->note_list[num].content = (char *)realloc(
                                               note_stru->note_list[num].content,
                                               (128 - length % 128) % 128 + length);
        note_stru->note_list[num].field_8 = length;
      }
      printf("Enter your note: ");
      read_str(note_stru->note_list[num].content, length);
      puts("Done.");
    }
    else
    {
      puts("Invalid length!");
    }
  }
  else
  {
    puts("Invalid number!");
  }
}

void delete()
{
  int num;

  if ( note_stru->count <= 0 )
  {
    puts("No notes yet.");
  }
  else
  {
    printf("Note number: ");
    num = read_num();
    if ( num >= 0 && num < note_stru->limit )
    {
      --note_stru->count;
      note_stru->note_list[num].used = 0LL;
      note_stru->note_list[num].field_8 = 0LL;
      free(note_stru->note_list[num].content);
      puts("Done.");
    }
    else
    {
      puts("Invalid number!");
    }
  }
}

__int64 __fastcall main(__int64 a1, char **a2, char **a3)
{
  init();
  init2();
  while ( 1 )
  {
    switch ( menu_and_read_choice() )
    {
      case 1:
        list();
        break;
      case 2:
        new();
        break;
      case 3:
        edit();
        break;
      case 4:
        delete();
        break;
      case 5:
        puts("Bye");
        return 0LL;
      default:
        puts("Invalid!");
        break;
    }
  }
}
