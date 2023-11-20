unsigned __int64 show_menu()
{
  unsigned __int64 v1;

  v1 = __readfsqword(0x28u);
  puts("=-=-=-=-=-=-=-=-=-=-=-=");
  puts("1. Open the book");
  puts("2. Read the book");
  puts("3. Revise the contents");
  puts("4. Close the book");
  puts("=-=-=-=-=-=-=-=-=-=-=-=");
  printf("> ");
  return __readfsqword(0x28u) ^ v1;
}
