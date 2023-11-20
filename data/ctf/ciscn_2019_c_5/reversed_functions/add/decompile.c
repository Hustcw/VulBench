void add()
{
  int v0;
  int size;
  unsigned __int64 v2;

  v2 = __readfsqword(0x28u);
  if ( count > 16 )
    puts("Enough!");
  puts("Please input the size of story: ");
  _isoc99_scanf("%d", &size);
  stories[count].size = size;
  v0 = count;
  stories[v0].content = (char *)malloc(size);
  puts("please inpute the story: ");
  read(0, stories[count].content, size);
  ++count;
  puts("Done!");
}