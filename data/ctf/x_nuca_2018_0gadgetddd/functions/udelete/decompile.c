ssize_t udelete()
{
  unsigned int v1;

  write(1, "Which Note do you want to delete: ", 0x22uLL);
  v1 = input_choice();
  if ( v1 >= 0x10 )
    return write(1, "Out of bound!\n", 0xEuLL);
  if ( *((_DWORD *)&notebook + 40 * (int)v1) )
  {
    free(*(void **)&dword_6020E4[40 * v1 + 37]);
    *((_DWORD *)&notebook + 40 * (int)v1) = 0;
  }
  return 0LL;
}
