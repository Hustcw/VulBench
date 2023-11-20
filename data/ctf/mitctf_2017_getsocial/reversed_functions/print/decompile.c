void print()
{
  int v0;
  Tweet *v1;

  v1 = head;
  v0 = 0;
  puts("######");
  while (v1)
  {
    printf("Tweet %d: %s\n", v0, v1->content);
    v1 = v1->next;
    ++v0;
  }
  puts("######");
}