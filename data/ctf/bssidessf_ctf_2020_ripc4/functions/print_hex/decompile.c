void __cdecl print_hex(const char *buf, size_t buflen)
{
  int i;

  for ( i = 0; buflen > i; ++i )
    printf("%02x", (unsigned __int8)buf[i]);
  putchar(10);
}
