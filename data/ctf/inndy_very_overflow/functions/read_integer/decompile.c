int read_integer()
{
  char buff[8];

  fgets(buff, 7, stdin);
  return atoi(buff);
}
