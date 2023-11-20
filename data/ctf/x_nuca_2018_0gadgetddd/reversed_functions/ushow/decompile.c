ssize_t ushow()
{
  unsigned int v1;
  int v2;

  write(1, "Which Note do you want to show: ", 0x20uLL);
  v1 = input_choice();
  if ( v1 >= 0x10 )
    return write(1, "Out of bound!\n", 0xEuLL);
  if ( notebook[v1].used )
  {
    write(1, "note title: ", 0xCuLL);
    v2 = strlen(notebook[v1].title);
    write(1, notebook[v1].title, v2);
    putchar('\n');
    write(1, "note content: ", 0xEuLL);
    write(1, notebook[v1].content, notebook[v1].size);
    putchar('\n');
  }
  return 0LL;
}