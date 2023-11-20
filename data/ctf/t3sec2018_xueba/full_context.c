struct Note
{
  char name[16];
  __int64 used;
  char *content;
};

int dword_20204C;
int note_count;
Note notes[5];
struct Note
{
  char name[16];
  __int64 used;
  char *content;
};

int dword_20204C;
int note_count;
Note notes[5];


void sub_A93()
{
  puts("1.Add a note");
  puts("2.Show a note");
  puts("3.Delete a note");
  puts("4.Change name of a note");
  puts("5.Exit");
}

void __fastcall read_str(char *a1, unsigned __int16 a2)
{
  a1[read(0, a1, a2)] = 0;
}

void sub_B0E()
{
  int v0;
  unsigned int i;
  unsigned __int64 v2;

  v2 = __readfsqword(0x28u);
  if ( note_count > 5 )
  {
    puts("You can't add any more notes!");
    exit(0);
  }
  for ( i = 0; i <= 4 && notes[i].used; ++i )
    ;
  puts("How long is your note?");
  _isoc99_scanf("%u", &v0);
  if ( i > 0x80 )
  {
    puts("Too long!");
    exit(0);
  }
  notes[i].used = 1LL;
  notes[i].content = (char *)malloc((unsigned int)(v0 + 1));
  puts("Input your note name and note content:");
  read_str(notes[i].name, 0x15u);
  read_str(notes[i].content, v0);
  ++note_count;
  puts("Done!");
}

void sub_C7E()
{
  int v0;
  unsigned __int64 v1;

  v1 = __readfsqword(0x28u);
  puts("Index:");
  _isoc99_scanf("%u", &v0);
  if ( notes[v0].used == 1 )
    printf("Name %s\nContent:%s\n", notes[v0].name, notes[v0].content);
  else
    puts("No such note!");
}

void sub_D3F()
{
  int v0;
  unsigned __int64 v1;

  v1 = __readfsqword(0x28u);
  puts("Index:");
  _isoc99_scanf("%u", &v0);
  if ( notes[v0].used == 1 )
  {
    free(notes[v0].content);
    notes[v0].used = 0LL;
    --note_count;
    puts("Done!");
  }
  else
  {
    puts("No such note!");
  }
}

void sub_E11()
{
  char *v0;
  char buf;
  char v2;
  int v3;
  unsigned __int64 v4;

  v4 = __readfsqword(0x28u);
  if ( dword_20204C > 1 )
  {
    puts("You are really annoying!");
    exit(0);
  }
  puts("Index:");
  _isoc99_scanf("%u", &v3);
  ++dword_20204C;
  puts("Which letter do you want to change?");
  read(0, &buf, 1uLL);
  if ( strchr(notes[v3].name, buf) )
  {
    read(0, &v2, 1uLL);
    v0 = strchr(notes[v3].name, buf);
    *v0 = v2;
    puts("Done!");
  }
  else
  {
    puts("No such letter");
  }
}

void __fastcall __noreturn main(__int64 a1, char **a2, char **a3)
{
  int v3;
  unsigned __int64 v4;

  v4 = __readfsqword(0x28u);
  sub_A50(a1, a2, a3);
  puts("Welcome to the xueba note system");
  while ( 1 )
  {
    sub_A93();
    _isoc99_scanf("%d", &v3);
    switch ( v3 )
    {
      case 1:
        sub_B0E();
        break;
      case 2:
        sub_C7E();
        break;
      case 3:
        sub_D3F();
        break;
      case 4:
        sub_E11();
        break;
      case 5:
        puts("Bye bye,hope you get good grades");
        exit(0);
      default:
        puts("Invalid option!");
        exit(0);
    }
  }
}
