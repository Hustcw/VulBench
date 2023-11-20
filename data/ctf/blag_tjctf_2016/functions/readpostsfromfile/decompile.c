unsigned int readpostsfromfile()
{
  int i;
  FILE *stream;
  char *v3;
  char s[320];
  unsigned int v5;

  v5 = __readgsdword(0x14u);
  stream = fopen("blogposts.txt", "r");
  if ( !stream )
  {
    printf("Can't read blog posts!");
    exit(1);
  }
  fgets(s, 320, stream);
  __isoc99_sscanf(s, "%d", &numposts);
  for ( i = 0; i < numposts; ++i )
  {
    v3 = (char *)*(&posts + i);
    readline(s, 320, stream);
    __isoc99_sscanf(s, "%d", v3);
    readline(s, 320, stream);
    strcpy(v3 + 4, s);
    readline(s, 320, stream);
    strcpy(v3 + 36, s);
    readline(s, 320, stream);
    strcpy(v3 + 68, s);
  }
  fclose(stream);
  return __readgsdword(0x14u) ^ v5;
}
