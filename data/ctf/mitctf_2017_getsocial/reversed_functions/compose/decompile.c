void __cdecl compose(void *src)
{
  struct Tweet *dest;
  int v2;
  Tweet *v3;
  Tweet *v4;

  v4 = head;
  v3 = 0;
  v2 = 0;
  while (v4)
  {
    v3 = v4;
    v4 = v4->next;
    if ((unsigned int)++v2 > 0xF423F)
    {
      puts("[MEMORY ERROR]");
      exit(0);
    }
  }
  dest = (struct Tweet *)malloc(0x90u);
  memcpy(dest, src, 0x8Cu);
  dest->content[139] = 0;
  v3->next = dest;
  ++tweet_count;
}