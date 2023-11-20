void list_paper()
{
  int i;

  puts("List of indexed papers:");
  for ( i = 0; i < count; ++i )
    printf("[%d] %s \"%s\"\n", (unsigned int)i, &paper[1088 * i + 256], &paper[1088 * i]);
  puts("\n");
}