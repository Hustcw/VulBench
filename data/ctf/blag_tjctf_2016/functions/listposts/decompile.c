unsigned int listposts()
{
  int i;
  unsigned int v2;

  v2 = __readgsdword(0x14u);
  for ( i = 0; i < numposts; ++i )
    printf("Post #%d: %s by %s\n", i, (const char *)*(&posts + i) + 36, (const char *)*(&posts + i) + 4);
  return __readgsdword(0x14u) ^ v2;
}
