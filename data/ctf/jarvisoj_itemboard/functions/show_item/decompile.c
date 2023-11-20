void __cdecl show_item()
{
  Item *item;
  int index;

  puts("Which item?");
  fflush(stdout);
  index = read_num();
  if ( index < items_cnt && item_array[index] )
  {
    item = item_array[(unsigned __int8)index];
    puts("Item Detail:");
    printf("Name:%s\n", item->name);
    printf("Description:%s\n", item->description);
    fflush(stdout);
  }
  else
  {
    puts("Hacker!");
  }
}
