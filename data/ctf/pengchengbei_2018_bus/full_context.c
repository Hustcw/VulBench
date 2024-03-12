__int64 dest_cnt;
__int64 idx;
char *destination[32];
_QWORD people_count[32];

void __fastcall sub_B72(char *a1, __int64 a2)
{
  unsigned __int64 i;

  for ( i = 0LL; i < a2 - 1; ++i )
  {
    read(0, &a1[i], 1uLL);
    if ( a1[i] == 10 )
    {
      a1[i] = 0;
      break;
    }
  }
  a1[i] = 0;
}

int sub_BEF()
{
  puts("1. buy a ticket");
  puts("2. select destination");
  puts("3. get on the bus and go");
  puts("4. exit");
  return printf("What do you want to do:");
}

__int64 __fastcall sub_C37(const char *a1)
{
  int i;

  for ( i = 0; i <= 31; ++i )
  {
    if ( destination[i] && !strcmp(a1, (const char *)destination[i]) )
      return (unsigned int)i;
  }
  return 0xFFFFFFFFLL;
}

void sub_CAA()
{
  int i;
  int v1;
  __int64 v2;
  char *dest;
  unsigned __int64 v4;

  v4 = __readfsqword(0x28u);
  for ( i = 0; i <= 31 && destination[i]; ++i )
    ;
  dest = (char *)malloc(0x80uLL);
  printf("Where do you want to go: ");
  sub_B72(dest, 128LL);
  v1 = sub_C37(dest);
  if ( v1 == -1 )
  {
    destination[i] = dest;
    ++dest_cnt;
  }
  else
  {
    puts("OK,more people huh?");
    i = v1;
    free(dest);
  }
  printf("How many people: ");
  __isoc99_scanf("%lu", &v2);
  people_count[i] += v2;
  puts("Done!");
}

void sub_E0B()
{
  char a1[128];
  unsigned __int64 v1;

  v1 = __readfsqword(0x28u);
  printf("Where is your destination:");
  sub_B72(a1, 128LL);
  idx = (int)sub_C37(a1);
  if ( idx == -1 )
    puts("No such place!");
  puts("Done!");
}

void sub_E9E()
{
  if ( idx == -1 )
  {
    puts("Select a destination first!");
  }
  else
  {
    puts("OK, let's go!");
    free(destination[idx]);
    destination[idx] = 0LL;
    people_count[idx] = 0LL;
    memcpy(&destination[idx], &destination[idx + 1], 8 * (dest_cnt - idx - 1));
    memcpy(&people_count[idx], &people_count[idx + 1], 8 * (dest_cnt - idx - 1));
    destination[--dest_cnt] = 0LL;
    people_count[dest_cnt] = 0LL;
    idx = -1LL;
  }
}

void __fastcall __noreturn main(int a1, char **a2, char **a3)
{
  int v3;
  unsigned __int64 v4;

  v4 = __readfsqword(0x28u);
  while ( 1 )
  {
    while ( 1 )
    {
      while ( 1 )
      {
        sub_BEF();
        __isoc99_scanf("%d", &v3);
        if ( v3 != 2 )
          break;
        sub_E0B();
      }
      if ( v3 > 2 )
        break;
      if ( v3 != 1 )
        goto LABEL_13;
      sub_CAA();
    }
    if ( v3 != 3 )
    {
      if ( v3 == 4 )
        exit(0);
LABEL_13:
      puts("Invalid choice!");
      exit(0);
    }
    sub_E9E();
  }
}