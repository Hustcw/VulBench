void delete()
{
  unsigned int v0;

  printf("Index: ");
  v0 = get_int();
  if ( v0 <= 0xF && ptrs[v0].content )
  {
    free(ptrs[v0].content);
    ptrs[v0].content = 0LL;
    ptrs[v0].size = 0;
    puts("Delete success :)");
  }
  else
  {
    puts("Invalid index :(");
  }
}