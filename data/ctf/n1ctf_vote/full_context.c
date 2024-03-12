struct Vote
{
  __int64 count;
  __int64 time;
  char name[8];
};

Vote *ptr[16];
int idx;
__int64 vote_list[16];


void __fastcall read_str(char *a1, unsigned __int64 a2)
{
  unsigned __int64 v2;

  v2 = 0LL;
  do
  {
    if ( read(0, &a1[v2], 1uLL) == -1 )
      exit(1);
    if ( a1[v2] == 10 )
    {
      a1[v2] = 0;
      return;
    }
    ++v2;
  }
  while ( v2 < a2 );
  a1[v2 - 1] = 0;
}

int __fastcall println(const char *a1)
{
  size_t v1;

  v1 = strlen(a1);
  write(1, a1, v1);
  write(1, &unk_401398, 1uLL);
  return fflush(stdout);
}

int __fastcall print(const char *a1)
{
  size_t v1;

  v1 = strlen(a1);
  write(1, a1, v1);
  return fflush(stdout);
}

int read_int()
{
  char s[8];
  unsigned __int64 v2;

  v2 = __readfsqword(0x28u);
  memset(s, 0, sizeof(s));
  read_str(s, 8uLL);
  return atoi(s);
}

void *__fastcall start_routine(void *a1)
{
  sleep(3u);
  ++vote_list[idx];
  return 0LL;
}

void create()
{
  int i;
  int v1;
  Vote *v2;

  for ( i = 0; i <= 15; ++i )
  {
    if ( !ptr[i] )
    {
      print("Please enter the name's size: ");
      v1 = read_int();
      if ( v1 > 0 && v1 <= 4096 )
      {
        v2 = (Vote *)malloc(v1 + 16);
        v2->count = 0LL;
        v2->time = time(0LL);
        print("Please enter the name: ");
        read_str(v2->name, v1);
        ptr[i] = v2;
      }
      return;
    }
  }
}

void show()
{
  unsigned int v0;
  char s[280];
  unsigned __int64 v2;

  v2 = __readfsqword(0x28u);
  memset(s, 0, 0x10AuLL);
  print("Please enter the index: ");
  v0 = read_int();
  if ( v0 <= 0xF )
  {
    if ( ptr[v0] )
    {
      snprintf(s, 0x100uLL, "name: %s\ncount: %lu\ntime: %lu", ptr[v0]->name, ptr[v0]->count, ptr[v0]->time);
      println(s);
    }
  }
}

void vote()
{
  __int64 *p_time;
  unsigned int v1;
  pthread_t newthread;
  unsigned __int64 v3;

  v3 = __readfsqword(0x28u);
  print("Please enter the index: ");
  v1 = read_int();
  if ( v1 <= 0xF )
  {
    if ( ptr[v1] )
    {
      ++ptr[v1]->count;
      p_time = &ptr[v1]->time;
      *p_time = time(0LL);
      idx = v1;
      pthread_create(&newthread, 0LL, start_routine, 0LL);
    }
  }
}

void result()
{
  int i;
  char s[280];
  unsigned __int64 v2;

  v2 = __readfsqword(0x28u);
  memset(s, 0, 0x10AuLL);
  for ( i = 0; i <= 15; ++i )
  {
    if ( vote_list[i] )
    {
      snprintf(s, 0x100uLL, "%d\t->\t%lu", (unsigned int)i, vote_list[i]);
      println(s);
      fflush(stdout);
    }
  }
}

void cancel()
{
  unsigned int v0;

  print("Please enter the index: ");
  v0 = read_int();
  if ( v0 <= 0xF && ptr[v0] )
  {
    if ( --vote_list[v0] == --ptr[v0]->count )
    {
      if ( vote_list[v0] < 0 )
        free(ptr[v0]);
    }
    else if ( vote_list[v0] < 0 )
    {
      printf("%s", ptr[idx]->name);
      fflush(stdout);
      println(" has freed");
      free(ptr[v0]);
      ptr[v0] = 0LL;
    }
  }
}

void __fastcall __noreturn main(int a1, char **a2, char **a3)
{
  int v3;
  unsigned __int64 v4;

  v4 = __readfsqword(0x28u);
  setvbuf(stdin, 0LL, 2, 0LL);
  alarm(0x1Eu);
  while ( 1 )
  {
    println("0: Create");
    println("1: Show");
    println("2: Vote");
    println("3: Result");
    println("4: Cancel");
    println("5: Exit");
    print("Action: ");
    if ( (unsigned int)__isoc99_scanf("%d", &v3) == -1 )
      break;
    if ( !v3 )
      create();
    if ( v3 == 1 )
      show();
    if ( v3 == 2 )
      vote();
    if ( v3 == 3 )
      result();
    if ( v3 == 4 )
      cancel();
    if ( v3 == 5 )
    {
      println("Bye");
      exit(0);
    }
  }
  exit(1);
}