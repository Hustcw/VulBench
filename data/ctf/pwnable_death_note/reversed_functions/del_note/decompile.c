int del_note()
{
  int result; // eax
  int v1; // [esp+Ch] [ebp-Ch]

  printf("Index :");
  v1 = read_int();
  if ( v1 > 10 )
  {
    puts("Out of bound !!");
    exit(0);
  }
  free(note[v1]);
  result = v1;
  note[v1] = 0;
  return result;
}