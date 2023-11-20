struct Data
{
  int used;
  int size;
  char *content;
};

Data games[20];
struct Data
{
  int used;
  int size;
  char *content;
};

Data games[20];


int sub_B5A()
{
  puts("Welcome to Children's Day Paradise.\nPlease give me your choice.");
  puts("1. GET TICKET");
  puts("2. PALY GANE");
  puts("3. GAME OVER");
  puts("4. LOOK GANE");
  puts("5. EXIT GAME");
  return printf("CHOICE: ");
}

__int64 __fastcall sub_BE0(int a1)
{
  int v2;
  int v3;
  unsigned __int64 v4;

  v2 = a1;
  v4 = __readfsqword(0x28u);
  v3 = _isoc99_scanf("%d", &v2);
  if ( (unsigned int)v2 < 0x101 )
    return (unsigned int)v2;
  else
    return '\n';
}

void sub_C46()
{
  int i;
  int v1;
  int v2;
  char *v3;

  for ( i = 0; i <= 15; ++i )
  {
    if ( !games[i].used )
    {
      printf("size: ");
      v2 = sub_BE0(v1);
      if ( v2 > 0 )
      {
        if ( v2 > 4096 )
          v2 = 4096;
        v3 = (char *)calloc(v2, 1uLL);
        if ( !v3 )
          exit(-1);
        games[i].used = 1;
        games[i].size = v2;
        games[i].content = v3;
        printf("The lowbits of heap leak check : %x\n", (__int64)games[i].content & 0xFFF);
        printf("the index of ticket is %d \n", (unsigned int)i);
      }
      return;
    }
  }
}

__int64 __fastcall sub_DA8(char *a1, int a2)
{
  __int64 v3;
  ssize_t v4;

  if ( !a2 )
    return 0LL;
  v3 = 0LL;
  while ( a2 > v3 )
  {
    v4 = read(0, &a1[v3], a2 - v3);
    if ( v4 > 0 )
      v3 += v4;
  }
  return v3;
}

__int64 __fastcall sub_E3C(int a1, int a2)
{
  __int64 result;

  if ( a1 > a2 )
    return (unsigned int)a2;
  if ( a2 - a1 == 10 )
    LODWORD(result) = a1 + 1;
  else
    LODWORD(result) = a1;
  return (unsigned int)result;
}

void sub_E98()
{
  int v0;
  unsigned int v1;
  int v2;
  unsigned int v3;
  int v4;

  printf("index: ");
  v1 = sub_BE0(v0);
  v3 = v1;
  if ( v1 <= 0xF && games[v1].used == 1 )
  {
    printf("size: ");
    v2 = sub_BE0(1);
    v4 = sub_E3C(games[v3].size, v2);
    if ( v2 > 0 )
    {
      printf("content: ");
      sub_DA8(games[v3].content, v4);
    }
  }
}

void sub_FA4()
{
  int v0;
  int v1;
  int v2;

  printf("index: ");
  v0 = sub_BE0(v2);
  v1 = v0;
  if ( (unsigned __int64)v0 <= 0xF && games[v0].used == 1LL )
  {
    games[v0].used = 0;
    games[v0].size = 0;
    free(games[v0].content);
    games[v1].content = 0LL;
  }
}

__int64 __fastcall print(char *a1, int a2)
{
  __int64 v3;
  ssize_t v4;

  if ( !a2 )
    return 0LL;
  v3 = 0LL;
  while ( a2 > v3 )
  {
    v4 = write(1, &a1[v3], a2 - v3);
    if ( v4 > 0 )
      v3 += v4;
  }
  return v3;
}

void sub_1138()
{
  int v0;
  unsigned int v1;

  printf("index: ");
  v1 = sub_BE0(v0);
  if ( v1 <= 0xF && games[v1].used == 1 )
  {
    printf("content: ");
    print(games[v1].content, games[v1].size);
  }
}

__int64 __fastcall main(int a1, char **a2, char **a3)
{
  int v4;

  while ( 1 )
  {
    sub_B5A();
    v4 = sub_BE0(v4);
    switch ( v4 )
    {
      case 1:
        puts("Have a good day!");
        sub_C46();
        break;
      case 2:
        puts("Here's a great thing!");
        sub_E98();
        break;
      case 3:
        puts("Are you sure?");
        sub_FA4();
        break;
      case 4:
        puts("Is there anything nice in the ticket?");
        sub_1138();
        break;
      case 5:
        puts("See you!");
        return 0LL;
      default:
        puts("Wrong choice!!!Please again!!!");
        break;
    }
  }
}
