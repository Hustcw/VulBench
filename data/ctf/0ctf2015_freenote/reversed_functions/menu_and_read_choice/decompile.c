int menu_and_read_choice()
{
  puts("== 0ops Free Note ==");
  puts("1. List Note");
  puts("2. New Note");
  puts("3. Edit Note");
  puts("4. Delete Note");
  puts("5. Exit");
  puts("====================");
  printf("Your choice: ");
  return read_num();
}