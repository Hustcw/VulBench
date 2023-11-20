_QWORD content_size[20]; // weak
char *content[20];
_BYTE *a1; // idb
_QWORD content_size[20]; // weak
char *content[20];
_BYTE *a1; // idb


void __fastcall read_str(_BYTE *a1, int a2)
{
  _BYTE *buf; // [rsp+10h] [rbp-10h]

  for ( buf = a1; &a1[a2] != buf && read(0, buf, 1uLL) == 1 && *buf != 10 && *buf; ++buf )
    ;
  *buf = 0;
}


int read_int()
{
  char s[40]; // [rsp+0h] [rbp-30h] BYREF
  unsigned __int64 v2; // [rsp+28h] [rbp-8h]

  v2 = __readfsqword(0x28u);
  memset(s, 0, 0x20uLL);
  read(0, s, 0xAuLL);
  return atoi(s);
}

void menu()
{
  puts("1. add");
  puts("2. show");
  puts("3. remove");
  puts("4. exit");
  printf("choice> ");
}

void add()
{
  int i; // [rsp+Ch] [rbp-24h]
  int j; // [rsp+10h] [rbp-20h]
  int a2; // [rsp+14h] [rbp-1Ch]
  unsigned __int64 size; // [rsp+18h] [rbp-18h]
  char *a1; // [rsp+20h] [rbp-10h]

  for ( i = 0; i <= 19 && content[i]; ++i )
    ;
  if ( i <= 20 )
  {
    printf("length> ");
    a2 = read_int();
    if ( a2 > 7 && a2 <= 512 )
    {
      size = (int)((a2 + 15) & 0xFFFFFFF8);
      a1 = (char *)malloc(size);
      for ( j = 0; j <= size; ++j )
        a1[j] = 0;
      printf("content> ");
      read_str(a1, a2);
      content[i] = a1;
      content_size[i] = size;
      puts("done");
    }
    else
    {
      puts("invalid length");
    }
  }
  else
  {
    puts("full");
  }
}

void remove()
{
  unsigned int v0; // [rsp+4h] [rbp-Ch]

  printf("index> ");
  v0 = read_int();
  if ( v0 <= 0x13 && content[v0] )
  {
    memset(content[v0], 0, content_size[v0]);
    free(content[v0]);
    content[v0] = 0LL;
    content_size[v0] = 0LL;
    puts("done");
  }
  else
  {
    puts("invalid index");
  }
}

unsigned __int64 show()
{
  unsigned int v1; // [rsp+4h] [rbp-Ch]
  unsigned __int64 v2; // [rsp+8h] [rbp-8h]

  v2 = __readfsqword(0x28u);
  printf("index> ");
  v1 = read_int();
  if ( v1 <= 0x13 && content[v1] )
    puts(content[v1]);
  else
    puts("invalid index");
  return __readfsqword(0x28u) ^ v2;
}

void __noreturn quit()
{
  printf("remarks> ");
  read_str(*((_BYTE **)a1 + 4), 64);
  printf("good bye %s\n", a1);
  free(a1);
  exit(0);
}

void __fastcall __noreturn main(__int64 a1, char **a2, char **a3)
{
  int v3; // eax

  init_0();
  while ( 1 )
  {
    while ( 1 )
    {
      menu();
      v3 = read_int();
      if ( v3 != 2 )
        break;
      show();
    }
    if ( v3 > 2 )
    {
      if ( v3 == 3 )
      {
        remove();
      }
      else
      {
        if ( v3 == 4 )
          quit();
LABEL_13:
        puts("Invalid option");
      }
    }
    else
    {
      if ( v3 != 1 )
        goto LABEL_13;
      add();
    }
  }
}
