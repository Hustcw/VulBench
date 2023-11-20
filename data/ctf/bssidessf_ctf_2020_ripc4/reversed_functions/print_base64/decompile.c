void __cdecl print_base64(const char *buf, size_t buflen)
{
  unsigned __int8 *encoded;

  encoded = base64_encode((const unsigned __int8 *)buf, buflen, 0LL);
  if ( encoded )
  {
    puts((const char *)encoded);
    free(encoded);
  }
}