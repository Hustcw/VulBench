__int64 __fastcall main(int rdi0, char **a2, char **rdx0)
{
  char a1[32];
  size_t a4;
  __off_t a3;

  disable_buf();
  _printf_chk(1LL, "Load file Service\nInput file name: ");
  getline(data, 128);
  _printf_chk(1LL, "Input offset: ");
  a3 = read_int();
  _printf_chk(1LL, "Input size: ");
  a4 = read_int();
  read_str_from_file(a1, data, a3, a4);
  close_fd();
  return 0LL;
}