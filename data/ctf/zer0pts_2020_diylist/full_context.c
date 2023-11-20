
struct List
{
  int len;
  int item_count;
  char **items;
};

void list_new()
{
  List *v0;

  v0 = (List *)malloc(0x10uLL);
  v0->len = 0;
  v0->item_count = 0;
  v0->items = 0LL;
}

void __fastcall list_add(List *a1, const char *a2, int a3)
{
  char **v3;
  char **src;

  if ( a1->len >= a1->item_count )
  {
    src = a1->items;
    a1->item_count += 4;
    a1->items = (char **)malloc(8LL * a1->item_count);
    if ( !a1->items )
      __list_abort("Allocation error");
    if ( src )
    {
      memcpy(a1->items, src, 8LL * (a1->item_count - 1));
      free(src);
    }
  }
  switch ( a3 )
  {
    case 2:
      a1->items[a1->len] = (char *)a2;
      break;
    case 3:
      v3 = &a1->items[a1->len];
      *v3 = strdup(a2);
      if ( fpool_num <= 63 )
        fpool[fpool_num++] = a1->items[a1->len];
      break;
    case 1:
      a1->items[a1->len] = (char *)a2;
      break;
    default:
      __list_abort("Invalid type");
  }
  ++a1->len;
}

char *__fastcall list_get(List *a1, int a2)
{
  if ( a2 < 0 || a2 >= a1->len )
    __list_abort("Out of bounds error");
  return a1->items[a2];
}

void __fastcall list_edit(List *a1, int a2, const char *a3, int a4)
{
  char **v4;

  if ( a2 < 0 || a2 >= a1->len )
    __list_abort("Out of bounds error");
  switch ( a4 )
  {
    case 2:
      a1->items[a2] = (char *)a3;
      break;
    case 3:
      v4 = &a1->items[a2];
      *v4 = strdup(a3);
      if ( fpool_num <= 63 )
        fpool[fpool_num++] = a1->items[a1->len];
      break;
    case 1:
      a1->items[a2] = (char *)a3;
      break;
    default:
      __list_abort("Invalid type");
  }
}

void __fastcall list_del(List *a1, int a2)
{
  int i;
  int j;
  char *ptr;

  if ( a2 < 0 || a2 >= a1->len )
    __list_abort("Out of bounds error");
  ptr = a1->items[a2];
  for ( i = a2; i < a1->len - 1; ++i )
    a1->items[i] = a1->items[i + 1];
  a1->items[i] = 0LL;
  --a1->len;
  for ( j = 0; j < fpool_num; ++j )
  {
    if ( (char *)fpool[j] == ptr )
    {
      free(ptr);
      return;
    }
  }
}

void __fastcall __noreturn _list_abort(const char *a1)
{
  fprintf(stderr, "[ABORT] %s\n", a1);
  exit(1);
}


__int64 read_long()
{
  char buf[24];
  unsigned __int64 v2;

  v2 = __readfsqword(0x28u);
  read(0, buf, 0xEuLL);
  return atol(buf);
}

double __fastcall read_float()
{
  char buf[24];
  unsigned __int64 v2;

  v2 = __readfsqword(0x28u);
  read(0, buf, 0xEuLL);
  return atof(buf);
}

void __fastcall read_str(char *a1)
{
  int v1;
  char *v2;

  v1 = read(0, a1, 0x7FuLL);
  v2 = strchr(a1, 10);
  if ( v2 )
    *v2 = 0;
  else
    a1[v1] = 0;
}

__int64 menu()
{
  puts("1. list_add");
  puts("2. list_get");
  puts("3. list_edit");
  puts("4. list_del");
  printf("> ");
  return read_long();
}

void __fastcall add(List *rdi0)
{
  __int64 v1;
  __int64 v2;
  double v3;
  char a1[136];
  unsigned __int64 v5;

  v5 = __readfsqword(0x28u);
  printf("Type(long=%d/double=%d/str=%d): ", 1LL, 2LL, 3LL);
  v1 = read_long();
  switch ( v1 )
  {
    case 2LL:
      printf("Data: ");
      v3 = read_float();
      list_add(rdi0, *(_QWORD *)&v3, 2LL);
      break;
    case 3LL:
      printf("Data: ");
      read_str(a1);
      list_add(rdi0, a1, 3LL);
      break;
    case 1LL:
      printf("Data: ");
      v2 = read_long();
      list_add(rdi0, v2, 1LL);
      break;
    default:
      puts("Invalid option");
      break;
  }
}

int __fastcall get(List *a1)
{
  __int64 v1;
  __int64 v2;
  const char *v4;
  double v5;
  unsigned int v6;

  printf("Index: ");
  v6 = read_long();
  printf("Type(long=%d/double=%d/str=%d): ", 1LL, 2LL, 3LL);
  v1 = read_long();
  switch ( v1 )
  {
    case 2LL:
      v5 = COERCE_DOUBLE(list_get(a1, v6));
      return printf("Data: %lf\n", v5);
    case 3LL:
      v4 = (const char *)list_get(a1, v6);
      return printf("Data: %s\n", v4);
    case 1LL:
      v2 = list_get(a1, v6);
      return printf("Data: %ld\n", v2);
    default:
      return puts("Invalid option");
  }
}

void __fastcall edit(List *a1)
{
  __int64 v1;
  __int64 v2;
  double v3;
  unsigned int v4;
  char a1a[136];
  unsigned __int64 v6;

  v6 = __readfsqword(0x28u);
  printf("Index: ");
  v4 = read_long();
  printf("Type(long=%d/double=%d/str=%d): ", 1LL, 2LL, 3LL);
  v1 = read_long();
  switch ( v1 )
  {
    case 2LL:
      printf("Data: ");
      v3 = read_float();
      list_edit(a1, v4, *(_QWORD *)&v3, 2LL);
      break;
    case 3LL:
      printf("Data: ");
      read_str(a1a);
      list_edit(a1, v4, a1a, 3LL);
      break;
    case 1LL:
      printf("Data: ");
      v2 = read_long();
      list_edit(a1, v4, v2, 1LL);
      break;
    default:
      puts("Invalid option");
      break;
  }
}

void __fastcall del(List *a1)
{
  unsigned int v1;

  printf("Index: ");
  v1 = read_long();
  list_del(a1, v1);
  puts("Successfully removed");
}

void sub_400F26()
{
  setbuf(stdin, 0LL);
  setbuf(stdout, 0LL);
  setbuf(stderr, 0LL);
}

void __fastcall __noreturn main(__int64 rdi0, char **a2, char **a3)
{
  __int64 v3;
  List *a1;

  sub_400F26();
  a1 = (List *)list_new(rdi0, a2);
  while ( 1 )
  {
    while ( 1 )
    {
      v3 = menu();
      if ( v3 != 2 )
        break;
      get(a1);
    }
    if ( v3 > 2 )
    {
      if ( v3 == 3 )
      {
        edit(a1);
      }
      else if ( v3 == 4 )
      {
        del(a1);
      }
    }
    else if ( v3 == 1 )
    {
      add(a1);
    }
  }
}

