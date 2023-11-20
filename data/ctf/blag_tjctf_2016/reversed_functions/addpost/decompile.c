void addpost()
{
  Post *v0;
  char src[32];
  unsigned int v2;

  v2 = __readgsdword(0x14u);
  if ( numposts <= 7 )
  {
    v0 = posts[numposts];
    puts("Author?");
    readline(src, 32, stdin);
    strcpy(v0->author, src);
    puts("Title?");
    readline(src, 32, stdin);
    strcpy(v0->title, src);
    puts("Body?");
    readline(src, 320, stdin);
    strcpy(v0->body, src);
    ++numposts;
  }
  else
  {
    puts("Blag is full!");
  }
}