unsigned int sub_804880D()
{
  sub_80488B1("\nTime Out!\n");
  close(fd);
  return __readgsdword(0x14u) ^ v1;
}