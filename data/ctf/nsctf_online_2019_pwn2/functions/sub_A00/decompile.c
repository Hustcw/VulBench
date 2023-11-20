ssize_t sub_A00()
{
  setvbuf(stdin, 0LL, 2, 0LL);
  setvbuf(stderr, 0LL, 2, 0LL);
  setvbuf(stdout, 0LL, 2, 0LL);
  puts("Welcome to notebook system");
  puts("Please input your name");
  return read(0, &unk_202060, 0x30uLL);
}
