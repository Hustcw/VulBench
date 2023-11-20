_DWORD dword_202040[64];
Data *qword_202140[62];
_DWORD dword_202040[64];
Data *qword_202140[62];

void __noreturn exit_()
{
  puts("ouch");
  exit(0);
}

__int64 __fastcall hash_str(unsigned __int8 *a1)
{
  unsigned __int8 *v1;
  unsigned int v4;

  v4 = 4919;
  while ( *a1 )
  {
    v1 = a1++;
    v4 = v4 * *v1 + 1;
  }
  return v4;
}

__int64 __fastcall sub_AC7(unsigned __int8 *a1)
{
  unsigned __int16 v3;

  v3 = 0;
  while ( *a1 && a1[1] )
  {
    v3 ^= *(_WORD *)a1;
    a1 += 2;
  }
  if ( *a1 )
    v3 ^= *a1;
  return ((v3 >> 10) ^ (unsigned __int8)(v3 ^ (v3 >> 5))) & 0x1F;
}

__int64 __fastcall sub_B38(_BYTE *a1)
{
  int i;
  unsigned int v4;

  v4 = 0;
  while ( *a1 )
  {
    for ( i = 0; i <= 7; ++i )
    {
      if ( (((int)(unsigned __int8)*a1 >> i) & 1) != 0 )
        LOBYTE(v4) = v4 + 1;
    }
    ++a1;
    v4 &= 0x1Fu;
  }
  return v4;
}

void __fastcall sub_B9A(int a1, char *a2, __int64 a3)
{
  Data *v4;

  v4 = (Data *)malloc(0x18uLL);
  if ( !v4 )
    exit_();
  v4->field_8 = a2;
  v4->field_10 = a3;
  v4->next = qword_202140[a1];
  qword_202140[a1] = v4;
}

void __fastcall sub_C14(int a1, char a2, char a3)
{
  dword_202040[a1] |= (1 << a2) | (1 << a3);
}

_BOOL8 __fastcall sub_C64(int a1, char a2, char a3)
{
  return (((1 << a2) | (1 << a3)) & dword_202040[a1]) == ((1 << a2) | (1 << a3));
}

void __fastcall sub_CB6(unsigned __int8 *a1, __int64 a2)
{
  char v2;
  char v3;
  int a1a;
  int a1b;

  a1a = hash_str(a1);
  v3 = sub_AC7(a1);
  v2 = sub_B38(a1);
  a1b = (int)abs32(a1a) % 62;
  sub_B9A(a1b, (char *)a1, a2);
  sub_C14(a1b, v3, v2);
}

char *__fastcall get_entry(char *a1)
{
  char v2;
  char v3;
  int v4;
  int v5;
  Data *i;

  v4 = hash_str((unsigned __int8 *)a1);
  v3 = sub_AC7((unsigned __int8 *)a1);
  v2 = sub_B38(a1);
  v5 = (int)abs32(v4) % 62;
  if ( !sub_C64(v5, v3, v2) )
    return 0LL;
  for ( i = qword_202140[v5]; i && strcmp(i->field_8, a1); i = i->next )
    ;
  return i->field_10;
}

__int64 __fastcall get_entry_by_name(char **a1, unsigned __int64 *a2)
{
  int v2;
  char buf[256];
  char *v5;
  ssize_t v6;

  memset(buf, 0, sizeof(buf));
  v6 = 0LL;
  v5 = 0LL;
  printf("Name: ");
  v2 = fileno(stdin);
  v6 = read(v2, buf, 0x100uLL);
  if ( v6 <= 0 )
    exit_();
  buf[255] = 0;
  v5 = get_entry(buf);
  if ( !v5 )
    return 0LL;
  *a2 = (unsigned __int64)v5 >> 48;
  *a1 = (char *)((unsigned __int64)v5 & 0xFFFFFFFFFFFFLL);
  return 1LL;
}

void add_entry()
{
  int v0;
  size_t v1;
  int v2;
  unsigned __int8 *name_;
  size_t size;
  char name[256];
  void *v6;
  ssize_t v7;

  memset(name, 0, sizeof(name));
  v7 = 0LL;
  size = 0LL;
  v6 = 0LL;
  printf("Name: ");
  v0 = fileno(stdin);
  v7 = read(v0, name, 0x100uLL);
  if ( v7 <= 0 )
    exit_();
  name[255] = 0;
  printf("Size: ");
  _isoc99_scanf("%lu", &size);
  fgetc(stdin);
  if ( size > 0x400 )
    exit_();
  v6 = malloc(size);
  if ( !v6 )
    exit_();
  printf("Value: ");
  v1 = size;
  v2 = fileno(stdin);
  v7 = read(v2, v6, v1);
  if ( v7 <= 0 )
    exit_();
  v6 = (void *)((size << 48) | (unsigned __int64)v6);
  name_ = (unsigned __int8 *)strdup(name);
  sub_CB6(name_, (__int64)v6);
}

void print_entry()
{
  size_t v0;
  char *v1;
  int fd;
  char *buf;
  size_t n;

  n = 0LL;
  buf = 0LL;
  if ( (unsigned int)get_entry_by_name(&buf, &n) )
  {
    printf("Value: ");
    v0 = n;
    v1 = buf;
    fd = fileno(stdout);
    write(fd, v1, v0);
    puts(byte_1446);
  }
  else
  {
    puts("No such entry!");
  }
}

void edit_entry()
{
  size_t v0;
  void *v1;
  int v2;
  char *s;
  __int64 n;

  n[0] = 0LL;
  s = 0LL;
  if ( (unsigned int)get_entry_by_name(&s, &n) )
  {
    printf("Value: ");
    memset(s, 0, n[0]);
    v0 = n[0];
    v1 = s;
    v2 = fileno(stdin);
    read(v2, v1, v0);
  }
  else
  {
    puts("No such entry!");
  }
}

void menu()
{
  puts("0. Exit");
  puts("1. Add entry");
  puts("2. Print entry");
  puts("3. Edit entry");
  printf("> ");
}

void __fastcall __noreturn main(int a1, char **a2, char **a3)
{
  int v3;

  v3 = 0;
  while ( 1 )
  {
    while ( 1 )
    {
      menu();
      _isoc99_scanf("%d", &v3);
      fgetc(stdin);
      if ( v3 != 1 )
        break;
      add_entry();
    }
    if ( v3 > 1 )
    {
      if ( v3 == 2 )
      {
        print_entry();
      }
      else
      {
        if ( v3 != 3 )
          goto LABEL_13;
        edit_entry();
      }
    }
    else
    {
      if ( !v3 )
        exit(0);
LABEL_13:
      puts("e?");
    }
  }
}
