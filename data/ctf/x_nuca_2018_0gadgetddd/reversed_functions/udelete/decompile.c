ssize_t udelete()
{
  unsigned int v1;

  write(1, "Which Note do you want to delete: ", 0x22uLL);
  v1 = input_choice();
  if ( v1 >= 0x10 )
    return write(1, "Out of bound!\n", 0xEuLL);
  if ( notebook[v1].used )
  {
    free(notebook[v1].content);
    notebook[v1].used = 0;
  }
  return 0LL;
}