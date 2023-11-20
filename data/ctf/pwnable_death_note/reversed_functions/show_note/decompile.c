char *show_note()
{
  char *result; // eax
  int v1; // [esp+Ch] [ebp-Ch]

  printf("Index :");
  v1 = read_int();
  if ( v1 > 10 )
  {
    puts("Out of bound !!");
    exit(0);
  }
  result = note[v1];
  if ( result )
    return (char *)printf("Name : %s\n", note[v1]);
  return result;
}