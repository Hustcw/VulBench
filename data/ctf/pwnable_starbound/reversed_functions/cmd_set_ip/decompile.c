void cmd_set_ip()
{
  size_t n;
  char src[268];

  __printf_chk(1, "Enter your IP address: ");
  n = readn(src, 0x100u);
  free(cp);
  cp = (char *)malloc(n);
  memcpy(cp, src, n);
  cp[n - 1] = 0;
}