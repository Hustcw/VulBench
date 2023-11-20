void add()
{
  Heap *v0;
  int i;
  int v2;

  for ( i = 0; ptrs[i].content && i <= 15; ++i )
    ;
  if ( i == 16 )
  {
    puts("You can't");
    exit(-1);
  }
  printf("Size: ");
  v2 = get_int();
  if ( v2 <= 0 || v2 > 4096 )
  {
    puts("Invalid size :(");
  }
  else
  {
    ptrs[i].size = v2;
    v0 = &ptrs[i];
    v0->content = (__int64)calloc(v2, 1uLL);
    puts("Add success :)");
  }
}