void delete()
{
  int v0;
  unsigned __int64 v1;

  v1 = __readfsqword(0x28u);
  puts("Please input the index:");
  _isoc99_scanf("%d", &v0);
  free(stories[v0].content);
  puts("Done!");
}