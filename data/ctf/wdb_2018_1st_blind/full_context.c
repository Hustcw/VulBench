char *a1[7];
char *a1[7];

void sub_4008E3()
{
  system("/bin/sh");
}

void sub_4008F4()
{
  puts("1.new");
  puts("2.change");
  puts("3.release");
  puts("4.exit");
  printf("Choice:");
}

void __fastcall sub_400932(char *a1, unsigned int a2)
{
  unsigned int i;

  for ( i = 0; i < a2; ++i )
  {
    read(0, &a1[i], 1uLL);
    if ( a1[i] == 10 || i == a2 - 1 )
    {
      a1[i] = 0;
      return;
    }
  }
}

void sub_4009A7()
{
  unsigned int v0;
  char s[24];
  unsigned __int64 v2;

  v2 = __readfsqword(0x28u);
  printf("Index:");
  memset(s, 0, 0x10uLL);
  read(0, s, 0xFuLL);
  v0 = atoi(s);
  if ( v0 <= 5 && !a1[v0] )
  {
    a1[v0] = malloc(0x68uLL);
    printf("Content:");
    sub_400932(a1[v0], 104LL);
    puts("Done!");
  }
}

void sub_400A80()
{
  unsigned int v0;
  char s[24];
  unsigned __int64 v2;

  v2 = __readfsqword(0x28u);
  printf("Index:");
  memset(s, 0, 0x10uLL);
  read(0, s, 0xFuLL);
  v0 = atoi(s);
  if ( v0 <= 5 )
  {
    if ( a1[v0] )
    {
      printf("Content:");
      sub_400932(a1[v0], 0x68u);
      puts("Done!");
    }
  }
}

void sub_400B41()
{
  unsigned int v0;
  char s[24];
  unsigned __int64 v2;

  v2 = __readfsqword(0x28u);
  printf("Index:");
  memset(s, 0, 0x10uLL);
  read(0, s, 0xFuLL);
  v0 = atoi(s);
  if ( v0 <= 5 && a1[v0] && dword_602098 <= 2 )
  {
    free(a1[v0]);
    ++dword_602098;
    puts("Done!");
  }
}

void __fastcall __noreturn main(__int64 a1, char **a2, char **a3)
{
  int v3;
  char s[24];
  unsigned __int64 v5;

  v5 = __readfsqword(0x28u);
  sub_400882();
  while ( 1 )
  {
    while ( 1 )
    {
      sub_4008F4();
      memset(s, 0, 0x10uLL);
      read(0, s, 0xFuLL);
      v3 = atoi(s);
      if ( v3 != 2 )
        break;
      sub_400A80();
    }
    if ( v3 == 3 )
    {
      sub_400B41();
    }
    else
    {
      if ( v3 != 1 )
        exit(0);
      sub_4009A7();
    }
  }
}
