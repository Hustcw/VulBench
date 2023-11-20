void init_0()
{
  Tweet *dest;
  int i;
  Tweet *v2;

  for (i = 0; i <= 2; ++i)
  {
    dest = (Tweet *)malloc(0x90u);
    if (!i)
    {
      head = dest;
      v2 = dest;
    }
    strcpy(dest->content, src[i]->content);
    dest->next = 0;
    v2->next = dest;
    v2 = dest;
  }
  tweet_count = 3;
}