int read_int()
{
  char buf[16];
  unsigned int v2;

  v2 = __readgsdword(0x14u);
  if ( read(0, buf, 0xFu) <= 0 )
  {
    puts("read error");
    exit(1);
  }
  return atoi(buf);
}
