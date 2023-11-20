int read_int()
{
  char nptr[8];

  readline(nptr, 7);
  return atoi(nptr);
}