int read_int()
{
  char nptr[32];

  nptr[0] = 0;
  getline(nptr, 32);
  return atoi(nptr);
}