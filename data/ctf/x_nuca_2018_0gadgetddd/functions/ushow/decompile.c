ssize_t ushow()
{
  int v1;
  int v2;

  write(1, "Which Note do you want to show: ", 0x20uLL);
  v1 = input_choice();
  if ( (unsigned int)v1 >= 0x10 )
    return write(1, "Out of bound!\n", 0xEuLL);
  if ( *((_DWORD *)&notebook + 40 * v1) )
  {
    write(1, "note title: ", 0xCuLL);
    v2 = strlen((const char *)(160LL * v1 + 6299880));
    write(1, (const void *)(160LL * v1 + 6299880), v2);
    putchar(10);
    write(1, "note content: ", 0xEuLL);
    write(1, *(const void **)&dword_6020E4[40 * v1 + 37], (int)dword_6020E4[40 * v1]);
    putchar(10);
  }
  return 0LL;
}
