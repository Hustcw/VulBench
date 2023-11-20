void __cdecl list_item()
{
  int i; // [rsp+Ch] [rbp-4h]

  puts("Item list");
  for ( i = 0; i < items_cnt; ++i )
  {
    if ( item_array[i] )
      printf("No.%d\tname:%s\n", (unsigned int)i, item_array[i]->name);
  }
  fflush(stdout);
}