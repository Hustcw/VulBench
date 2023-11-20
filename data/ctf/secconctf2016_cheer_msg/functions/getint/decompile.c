int getint()
{
  char nptr[64];
  unsigned int v2;

  v2 = __readgsdword(0x14u);
  getnline(nptr, 64);
  return atoi(nptr);
}
