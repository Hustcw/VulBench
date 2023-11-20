void __cdecl new_item()
{
  int v0;
  char buf[1024];
  int content_len;
  Item *item;

  item = (Item *)malloc(0x18uLL);
  v0 = items_cnt++;
  item_array[v0] = item;
  item->name = (char *)malloc(0x20uLL);
  item->free = (void (*)(ItemStruct *))item_free;
  puts("New Item");
  puts("Item name?");
  fflush(stdout);
  read_until(0, buf, 32, 10);
  strcpy(item->name, buf);
  puts("Description's len?");
  fflush(stdout);
  content_len = read_num();
  item->description = (char *)malloc(content_len);
  puts("Description?");
  fflush(stdout);
  read_until(0, buf, content_len, 10);
  strcpy(item->description, buf);
  puts("Add Item Successfully!");
}
