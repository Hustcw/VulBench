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