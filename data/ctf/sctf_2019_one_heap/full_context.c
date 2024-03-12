void *ptr;
int delete_count = 4;
int new_count = 2;

void __fastcall __noreturn main(__int64 a1, char **a2, char **a3)
{
  int i;

  while ( 1 )
  {
    for ( i = menu_and_read_choice(); i != 1; i = menu_and_read_choice() )
    {
      if ( i != 2 )
        exit(0);
      delete();
    }
    new();
  }
}

void __fastcall read_str(_BYTE *a1, __int64 a2)
{
  _BYTE *v2;
  char buf;
  unsigned __int64 v4;

  v4 = __readfsqword(0x28u);
  if ( a2 )
  {
    v2 = a1;
    do
    {
      buf = 0;
      if ( read(0, &buf, 1uLL) < 0 )
      {
        puts("Read error!!\n");
        exit(1);
      }
      if ( buf == 10 )
        break;
      *v2++ = buf;
    }
    while ( v2 != &a1[a2] );
  }
}

__int64 read_num()
{
  char v1[8];
  unsigned __int64 v2;

  *(_QWORD *)v1 = 0LL;
  v2 = __readfsqword(0x28u);
  read_str(v1, 8LL);
  return strtol(v1, 0LL, 10);
}

__int64 menu_and_read_choice()
{
  puts("1. new");
  puts("2. delete");
  _printf_chk(1LL, "Your choice:");
  return read_num();
}

void new()
{
  unsigned int v0;
  size_t v1;

  if ( !new_count )
LABEL_5:
    exit(0);
  _printf_chk(1LL, "Input the size:");
  v0 = read_num();
  v1 = (int)v0;
  if ( v0 > 0x7F )
  {
    puts("Invalid size!");
    goto LABEL_5;
  }
  _printf_chk(1LL, "Input the content:");
  ptr = malloc(v1);
  read_str(ptr, v1);
  puts("Done!");
  --new_count;
}

void delete()
{
  if ( !delete_count )
    exit(0);
  free(ptr);
  puts("Done!");
  --delete_count;
}