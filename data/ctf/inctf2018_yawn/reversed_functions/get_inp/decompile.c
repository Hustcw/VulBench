int __cdecl get_inp(char *buffer, int size)
{
  int retval;

  retval = read(0, buffer, size);
  if ( retval == -1 )
    exit(0);
  if ( buffer[retval - 1] == 10 )
    buffer[retval - 1] = 0;
  return retval - 1;
}