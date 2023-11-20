int show_note()
{
  int result;
  int v1;

  printf("Index :");
  v1 = read_int();
  if ( v1 > 10 )
  {
    puts("Out of bound !!");
    exit(0);
  }
  result = (int)*(&note + v1);
  if ( result )
    return printf("Name : %s\n", (const char *)*(&note + v1));
  return result;
}
