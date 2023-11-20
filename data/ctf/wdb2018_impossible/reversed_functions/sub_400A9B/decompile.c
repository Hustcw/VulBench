void sub_400A9B()
{
  char s[8];

  puts("This is a really powerful weapon...(to leak the secret code I think?)");
  memset(s, 0, sizeof(s));
  read(0, s, 2uLL);
  printf(s, 1LL);
}