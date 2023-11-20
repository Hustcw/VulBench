void show()
{
  unsigned int v0;

  printf("Index: ");
  v0 = get_int();
  if ( v0 <= 0xF && ptrs[v0].content )
    puts(ptrs[v0].content);
  else
    puts("Invalid index :(");
}