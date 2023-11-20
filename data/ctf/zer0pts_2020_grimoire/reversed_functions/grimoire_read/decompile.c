void grimoire_read()
{
  unsigned __int16 v0;
  char s[520];

  if ( !fp )
  {
    puts("You don't even open the book.");
    return;
  }
  if ( !init )
  {
    init = 1;
    fseek(fp, 0LL, 2);
    v0 = ftell(fp);
    fseek(fp, 0LL, 0);
    memset(s, 0, 0x200uLL);
    if ( !fread(s, 1uLL, v0, fp) )
    {
      error("fread", "Empty file stream");
      return;
    }
    qmemcpy(text, s, sizeof(text));
  }
  puts("*----------------------------------------*");
  printf("%s", text);
  puts("*----------------------------------------*");
}