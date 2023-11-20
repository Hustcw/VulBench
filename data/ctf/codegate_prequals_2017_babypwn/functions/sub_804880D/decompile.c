unsigned int sub_804880D()
{
  unsigned int v1;

  v1 = __readgsdword(0x14u);
  sub_80488B1("\nTime Out!\n");
  close(fd);
  return __readgsdword(0x14u) ^ v1;
}
