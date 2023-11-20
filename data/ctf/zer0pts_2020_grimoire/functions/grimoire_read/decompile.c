unsigned __int64 grimoire_read()
{
  unsigned __int16 v1;
  char s[520];
  unsigned __int64 v3;

  v3 = __readfsqword(0x28u);
  if ( fp )
  {
    if ( !init )
    {
      init = 1;
      fseek(fp, 0LL, 2);
      v1 = ftell(fp);
      fseek(fp, 0LL, 0);
      memset(s, 0, 0x200uLL);
      if ( !fread(s, 1uLL, v1, fp) )
      {
        error("fread", "Empty file stream");
        return __readfsqword(0x28u) ^ v3;
      }
      qmemcpy(text, s, sizeof(text));
    }
    puts("*----------------------------------------*");
    printf("%s", text);
    puts("*----------------------------------------*");
    return __readfsqword(0x28u) ^ v3;
  }
  puts("You don't even open the book.");
  return __readfsqword(0x28u) ^ v3;
}
