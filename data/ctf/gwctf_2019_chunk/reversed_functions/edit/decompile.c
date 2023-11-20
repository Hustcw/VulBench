void edit()
{
  int v0;
  unsigned __int64 v1;

  v1 = __readfsqword(0x28u);
  printf("Which book to write?");
  _isoc99_scanf("%d", &v0);
  printf("Content: ");
  read_str(chunk[v0], size[v0]);
  puts("Done!\n");
}