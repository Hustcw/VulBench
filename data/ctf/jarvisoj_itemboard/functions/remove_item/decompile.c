void __cdecl remove_item()
{
  int index;

  puts("Which item?");
  fflush(stdout);
  index = read_num();
  if ( index < items_cnt && item_array[index] )
  {
    item_array[index]->free(item_array[index]);
    set_null(item_array[index]);
    puts("The item has been removed");
    fflush(stdout);
  }
  else
  {
    puts("Hacker!");
  }
}
