unsigned int addpost()
{
  char *v1;
  char src[32];
  unsigned int v3;

  v3 = __readgsdword(0x14u);
  if ( numposts <= 7 )
  {
    v1 = (char *)*(&posts + numposts);
    puts("Author?");
    readline(src, 32, (FILE *)stdin);
    strcpy(v1 + 4, src);
    puts("Title?");
    readline(src, 32, (FILE *)stdin);
    strcpy(v1 + 36, src);
    puts("Body?");
    readline(src, 320, (FILE *)stdin);
    strcpy(v1 + 68, src);
    ++numposts;
  }
  else
  {
    puts("Blag is full!");
  }
  return __readgsdword(0x14u) ^ v3;
}
