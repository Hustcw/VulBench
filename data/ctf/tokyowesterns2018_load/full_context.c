char data[128];
char data[128];

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

void disable_buf()
{
  setbuf(stdin, 0LL);
  setbuf(stdout, 0LL);
}

void close_fd()
{
  close(0);
  close(1);
  close(2);
}

void __fastcall read_str_from_file(void *a1, const char *a2, __off_t a3, size_t a4)
{
  int fd;

  fd = open(a2, 0);
  if ( fd == -1 )
  {
    puts("You can't read this file...");
  }
  else
  {
    lseek(fd, a3, 0);
    if ( read(fd, a1, a4) > 0 )
      puts("Load file complete!");
    close(fd);
  }
}

void __fastcall getline(char *a1, int a2)
{
  char *v2;

  if ( a2 >= 0 )
  {
    fgets(a1, a2, stdin);
    v2 = strchr(a1, 10);
    if ( v2 )
      *v2 = 0;
  }
}

int read_int()
{
  char nptr[32];

  nptr[0] = 0;
  getline(nptr, 32);
  return atoi(nptr);
}
