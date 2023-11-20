int __cdecl read_until(int fd, char *buf, int len, char endchar)
{
  int i; // [rsp+2Ch] [rbp-4h]

  for ( i = 0; len - 1 > i; ++i )
  {
    if ( read(fd, &buf[i], 1uLL) <= 0 )
      return -1;
    if ( buf[i] == endchar )
      break;
  }
  buf[i] = 0;
  return i;
}