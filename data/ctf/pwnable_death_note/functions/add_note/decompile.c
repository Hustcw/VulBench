unsigned int add_note()
{
  int v1;
  char s[80];
  unsigned int v3;

  v3 = __readgsdword(0x14u);
  printf("Index :");
  v1 = read_int();
  if ( v1 > 10 )
  {
    puts("Out of bound !!");
    exit(0);
  }
  printf("Name :");
  read_input((unsigned __int8 *)s, 0x50u);
  if ( !is_printable(s) )
  {
    puts("It must be a printable name !");
    exit(-1);
  }
  *(&note + v1) = strdup(s);
  puts("Done !");
  return __readgsdword(0x14u) ^ v3;
}
