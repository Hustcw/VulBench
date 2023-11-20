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