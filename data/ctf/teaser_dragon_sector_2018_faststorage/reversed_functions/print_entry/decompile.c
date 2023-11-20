void print_entry()
{
  size_t v0;
  char *v1;
  int fd;
  char *buf;
  size_t n;

  n = 0LL;
  buf = 0LL;
  if ( (unsigned int)get_entry_by_name(&buf, &n) )
  {
    printf("Value: ");
    v0 = n;
    v1 = buf;
    fd = fileno(stdout);
    write(fd, v1, v0);
    puts(byte_1446);
  }
  else
  {
    puts("No such entry!");
  }
}