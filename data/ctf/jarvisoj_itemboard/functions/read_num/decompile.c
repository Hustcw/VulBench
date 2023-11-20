int __cdecl read_num()
{
  char buf[32];

  memset(buf, 0, sizeof(buf));
  if ( read_until(0, buf, 32, 10) >= 0 )
    return atoi(buf);
  else
    return -1;
}
