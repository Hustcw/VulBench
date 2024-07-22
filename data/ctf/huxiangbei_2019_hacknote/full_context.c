
struct List
{
  char *list[16];
  __int64 size[16];
};

_BOOL8 __fastcall check_idx(unsigned int a1, char **a2)
{
  return a1 <= 0xF && a2[a1] != 0LL;
}

void __fastcall __noreturn main(int a1, char **a2, char **a3)
{
  int v3;
  List a1a;
  int v5;

  puts("Welcome to Hacker's Note");
  while ( 1 )
  {
    while ( 1 )
    {
      v3 = read_long();
      v5 = v3;
      if ( v3 != 2 )
        break;
      delete(&a1a);
    }
    if ( v3 > 2 )
    {
      if ( v3 == 3 )
      {
        edit(&a1a);
      }
      else
      {
        if ( v3 == 4 )
        {
          puts("see u ~");
          exit(0);
        }
LABEL_13:
        puts("Invaild choice!");
      }
    }
    else
    {
      if ( v3 != 1 )
        goto LABEL_13;
      add(&a1a);
    }
  }
}

__int64 __fastcall add(List *a1)
{
  int size;
  int v3;
  int i;

  v3 = -1;
  for ( i = 0; i <= 15; ++i )
  {
    if ( !a1->size[i] )
    {
      v3 = i;
      printf((__int64)"You Get Index : %d\n", (unsigned int)i);
      break;
    }
  }
  if ( v3 == -1 )
  {
    puts("List Full !");
    return 0LL;
  }
  else
  {
    puts("Input the Size:");
    size = read_long();
    a1->list[v3] = (char *)malloc(size);
    if ( a1->list[v3] )
    {
      a1->size[v3] = size;
      puts("Input the Note:");
      read_str(a1->list[v3], size);
      puts("Add Done!");
    }
    else
    {
      puts("Allocation Failed !");
    }
    return 0LL;
  }
}

void __fastcall read_str(char *a1, int a2)
{
  int i;

  for ( i = 0; i < a2; ++i )
  {
    if ( (unsigned int)read(0LL, &a1[i], 1LL) != 1 )
      exit(1);
    if ( a1[i] == 10 )
    {
      a1[i] = 0;
      return;
    }
  }
}

__int64 __fastcall delete(List *a1)
{
  unsigned int v2;

  puts("Input the Index of Note:");
  v2 = read_long();
  if ( !check_idx(v2, a1->list) )
  {
    puts("Invaild !!");
  }
  else
  {
    a1->size[v2] = 0LL;
    free(a1->list[v2]);
    a1->list[v2] = 0LL;
    puts("Delete Done!");
  }
  return 0LL;
}

__int64 read_long()
{
  char v1[44];

  read_str(v1, 30LL);
  return (unsigned int)strtoll(v1);
}

__int64 __fastcall edit(List *a1)
{
  unsigned int v2;

  puts("Input the Index of Note:");
  v2 = read_long();
  if ( !check_idx(v2, a1->list) )
  {
    puts("Invaild !!");
  }
  else
  {
    puts("Input the Note:");
    read_str(a1->list[v2], a1->size[v2]);
    a1->size[v2] = (int)strlen(a1->list[v2]);
    puts("Edit Done!");
  }
  return 0LL;
}