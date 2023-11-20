struct note
{
  char name[80];
  __int64 size;
  char *desc;
};

note *table[10];
struct note
{
  char name[80];
  __int64 size;
  char *desc;
};

note *table[10];

int __cdecl get_inp(char *buffer, int size)
{
  int retval;

  retval = read(0, buffer, size);
  if ( retval == -1 )
    exit(0);
  if ( buffer[retval - 1] == 10 )
    buffer[retval - 1] = 0;
  return retval - 1;
}

int __cdecl get_int()
{
  char buffer[32];
  unsigned __int64 v2;

  v2 = __readfsqword(0x28u);
  get_inp(buffer, 32);
  return atoi(buffer);
}

__int64 __cdecl get_ll()
{
  char buffer[32];
  unsigned __int64 v2;

  v2 = __readfsqword(0x28u);
  get_inp(buffer, 32);
  return atoll(buffer);
}

int __cdecl insert(char *name, __int64 size, char *desc, int idx)
{
  table[idx]->size = size;
  table[idx]->desc = desc;
  strcpy(table[idx]->name, name);
  return 0;
}

int __cdecl add_note()
{
  int i;
  size_t size;
  char *ptr;
  char name[80];
  char desc[256];
  unsigned __int64 v6;

  v6 = __readfsqword(0x28u);
  memset(desc, 0, sizeof(desc));
  memset(name, 0, sizeof(name));
  for ( i = 0; i <= 9 && table[i]; ++i )
    ;
  if ( i == 10 )
    return 0;
  printf("ID : %d\n", (unsigned int)i);
  printf("Enter name: ");
  fgets(name, 81, stdin);
  printf("Enter desc: ");
  fgets(desc, 257, stdin);
  size = strlen(desc);
  ptr = strdup(desc);
  table[i] = (note *)malloc(0x60uLL);
  insert(name, size, ptr, i);
  return i;
}

int __cdecl edit_note()
{
  unsigned int idx;
  char *ptr;
  __int64 size;
  char name[80];
  char desc[256];
  unsigned __int64 v6;

  v6 = __readfsqword(0x28u);
  memset(desc, 0, sizeof(desc));
  memset(name, 0, sizeof(name));
  printf("Enter index: ");
  idx = get_int();
  if ( idx > 9 || !table[idx] )
    return 0;
  printf("Enter name: ");
  fgets(name, 81, stdin);
  printf("Enter size: ");
  size = get_ll();
  printf("Enter desc: ");
  if ( size > 256 )
  {
    ptr = (char *)malloc(size);
    fgets(ptr, size + 1, stdin);
  }
  else
  {
    fgets(desc, 257, stdin);
    ptr = strdup(desc);
  }
  insert(name, size, ptr, idx);
  return 0;
}

int __cdecl remove_note()
{
  unsigned int idx;

  printf("Enter idx: ");
  idx = get_int();
  if ( idx > 9 || !table[idx] )
    return 0;
  free(table[idx]->desc);
  table[idx]->desc = 0LL;
  free(table[idx]);
  table[idx] = 0LL;
  return 0;
}

int __cdecl view_note()
{
  unsigned int idx;

  printf("Enter idx: ");
  idx = get_int();
  if ( idx > 9 || !table[idx] )
    return 0;
  printf("Note ID : %d\nName : %s\n", idx, table[idx]->name);
  printf("Size : %lld\nDescription : %s\n", table[idx]->size, table[idx]->desc);
  return 0;
}

int __cdecl printmenu()
{
  puts("1) Add note\n2) Edit note\n3) Remove note\n4) View note\n5) Exit");
  printf(">> ");
  return get_int();
}

int __cdecl main(int argc, const char **argv, const char **envp)
{
  setvbuf(stdout, 0LL, 2, 0LL);
  puts("---------------------------");
  while ( 1 )
  {
    switch ( printmenu() )
    {
      case 1:
        add_note();
        break;
      case 2:
        edit_note();
        break;
      case 3:
        remove_note();
        break;
      case 4:
        view_note();
        break;
      case 5:
        exit(0);
      default:
        puts("Invalid");
        break;
    }
  }
}
