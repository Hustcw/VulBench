void edit()
{
  unsigned int v0;

  printf("Index: ");
  v0 = get_int();
  if ( v0 <= 0xF && ptrs[v0].content )
  {
    printf("Content: ");
    ptrs[v0].content[(int)read_n(ptrs[v0].content, (unsigned int)ptrs[v0].size)] = 0;
    puts("Edit success :)");
  }
  else
  {
    puts("Invalid index :(");
  }
}