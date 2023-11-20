struct ItemStruct
{
  char *name;
  char *description;
  void (*free)(ItemStruct *);
};

typedef ItemStruct Item;

Item **item_array;
struct ItemStruct
{
  char *name;
  char *description;
  void (*free)(ItemStruct *);
};

typedef ItemStruct Item;

Item **item_array;
int __cdecl main(int argc, const char **argv, const char **envp)
{
  int result; // eax
  int choice; // [rsp+Ch] [rbp-4h]

  item_array = (Item **)malloc(0xA0uLL);
  while ( 2 )
  {
    choice = read_num();
    if ( choice == -1 )
      return 0;
    switch ( choice )
    {
      case 1:
        new_item();
        continue;
      case 2:
        list_item();
        continue;
      case 3:
        show_item();
        continue;
      case 4:
        remove_item();
        continue;
      case 5:
        result = 0;
        break;
      default:
        puts("Invalid choice!");
        fflush(stdout);
        continue;
    }
    break;
  }
  return result;
}

void __cdecl new_item()
{
  int v0; // eax
  char buf[1024]; // [rsp+0h] [rbp-410h] BYREF
  int content_len; // [rsp+404h] [rbp-Ch]
  Item *item; // [rsp+408h] [rbp-8h]

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

int __cdecl read_until(int fd, char *buf, int len, char endchar)
{
  int i; // [rsp+2Ch] [rbp-4h]

  for ( i = 0; len - 1 > i; ++i )
  {
    if ( read(fd, &buf[i], 1uLL) <= 0 )
      return -1;
    if ( buf[i] == endchar )
      break;
  }
  buf[i] = 0;
  return i;
}

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

void __cdecl show_item()
{
  Item *item; // [rsp+0h] [rbp-10h]
  int index; // [rsp+Ch] [rbp-4h]

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

void __cdecl remove_item()
{
  int index; // [rsp+Ch] [rbp-4h]

  puts("Which item?");
  fflush(stdout);
  index = read_num();
  if ( index < items_cnt && item_array[index] )
  {
    item_array[index]->free(item_array[index]);
    dummy(item_array[index]);
    puts("The item has been removed");
    fflush(stdout);
  }
  else
  {
    puts("Hacker!");
  }
}

void __cdecl dummy(Item *offset)
{
  ;
}

void __cdecl item_free(Item *item)
{
  free(item->name);
  free(item->description);
  free(item);
}