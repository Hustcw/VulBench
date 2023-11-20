unsigned __int8 *__cdecl read_input(unsigned __int8 *buf, size_t nbytes)
{
  unsigned __int8 *result;
  ssize_t v3;

  v3 = read(0, buf, nbytes);
  if ( v3 <= 0 )
  {
    puts("read error");
    exit(1);
  }
  result = (unsigned __int8 *)buf[v3 - 1];
  if ( (_BYTE)result == 10 )
  {
    result = &buf[v3 - 1];
    *result = 0;
  }
  return result;
}
