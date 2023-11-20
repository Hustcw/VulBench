int choose()
{
  puts("1) add note");
  puts("2) edit note");
  puts("3) show note");
  puts("4) dump notes");
  puts("5) exit");
  printf("Your action: ");
  return read_integer();
}