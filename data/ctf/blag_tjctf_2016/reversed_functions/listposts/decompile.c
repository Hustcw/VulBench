void listposts()
{
  int i;

  for ( i = 0; i < numposts; ++i )
    printf("Post #%d: %s by %s\n", i, posts[i]->title, posts[i]->author);
}