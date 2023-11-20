ssize_t menu()
{
  puts("--------------------");
  puts("------- note -------");
  puts("--------------------");
  puts("1. new");
  puts("2. delete");
  puts("3. write");
  puts("4. exit");
  return write(1, ">> ", 3uLL);
}
