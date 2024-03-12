_DWORD size[16];
char *notes[10];

void __cdecl menu()
{
  puts("1.Add note");
  puts("2.Delete note");
  puts("3.Show note");
  puts("4.Update note");
  puts("5.exit");
}

void add()
{
  int v0;
  int i;
  void *s;
  unsigned __int64 v3;

  v3 = __readfsqword(0x28u);
  v0 = 0;
  for ( i = 0; notes[i]; ++i )
    ;
  if ( i <= 9 )
  {
    puts("Input the size:");
    _isoc99_scanf("%d", &v0);
    if ( v0 <= 0 || v0 > 1023 )
    {
      puts("Size error!");
    }
    else
    {
      s = malloc(v0);
      if ( s )
      {
        memset(s, 0, v0);
        notes[i] = (char *)s;
        size[i] = v0;
        puts("Input the content:");
        read(0, s, v0);
        puts("Add success");
      }
    }
  }
  else
  {
    puts("The list is full");
  }
}

void delete()
{
  unsigned int v0;
  unsigned __int64 v1;

  v1 = __readfsqword(0x28u);
  puts("Input the index:");
  v0 = 0;
  _isoc99_scanf("%d", &v0);
  if ( v0 <= 9 && notes[v0] )
  {
    free(notes[v0]);
    notes[v0] = 0LL;
    size[v0] = 0;
    puts("Delete success");
  }
  else
  {
    puts("Delete fail");
  }
}

int show()
{
  return puts("No show haha!");
}

void update()
{
  int v0;
  unsigned int nbytes;
  int nbytes_4;
  unsigned __int64 v3;

  v3 = __readfsqword(0x28u);
  puts("Input the index:");
  v0 = 0;
  nbytes = 0;
  _isoc99_scanf("%d", &v0);
  if ( v0 <= 9 && notes[v0] )
  {
    puts("Input size:");
    _isoc99_scanf("%d", &nbytes);
    if ( size[v0] < nbytes )
      nbytes = size[v0];
    puts("Input new content:");
    nbytes_4 = read(0, notes[v0], nbytes);
    if ( size[v0] == nbytes_4 )
      notes[v0][nbytes_4] = 0;
  }
  else
  {
    puts("Edit fail");
  }
}

__int64 __fastcall main(__int64 a1, char **a2, char **a3)
{
  int v4;
  unsigned __int64 v5;

  v5 = __readfsqword(0x28u);
  v4 = 0;
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
        return 0LL;
      default:
        puts("Wrong choice");
        break;
    }
  }
}