ssize_t __cdecl readn(void *buf, size_t nbytes)
{
  ssize_t result;

  result = read(0, buf, nbytes);
  if ( result <= 0 )
    exit(0);
  return result;
}