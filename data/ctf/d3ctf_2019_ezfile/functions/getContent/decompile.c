int __cdecl getContent(char *buf, int size)
{
  int i;

  for ( i = 0; i < size; ++i )
  {
    if ( (unsigned int)read(0, &buf[i], 1uLL) == -1 )
      exit(0);
    if ( buf[i] == 10 )
      return i + 1;
  }
  return i;
}
