int count()
{
  int v1;
  Tweet *v2;

  v2 = head;
  v1 = 0;
  while (v2)
  {
    if (++v1 == 1000000)
    {
      system("cat flag");
      exit(0);
    }
    v2 = v2->next;
  }
  return printf("There are %zu tweets\n", v1);
}