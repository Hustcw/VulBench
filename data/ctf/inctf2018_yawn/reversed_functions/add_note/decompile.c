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