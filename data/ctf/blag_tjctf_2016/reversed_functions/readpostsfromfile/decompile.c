void readpostsfromfile()
{
  int i;
  FILE *stream;
  Post *v2;
  char s[320];
  unsigned int v4;

  v4 = __readgsdword(0x14u);
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
    v2 = posts[i];
    readline(s, 320, stream);
    __isoc99_sscanf(s, "%d", v2);
    readline(s, 320, stream);
    strcpy(v2->author, s);
    readline(s, 320, stream);
    strcpy(v2->title, s);
    readline(s, 320, stream);
    strcpy(v2->body, s);
  }
  fclose(stream);
}