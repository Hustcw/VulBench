void add()
{
  unsigned int v0;
  unsigned int v1;
  unsigned int v2;
  unsigned __int64 v3;

  v3 = __readfsqword(0x28u);
  printf("Give me a book ID: ");
  _isoc99_scanf("%d", &v1);
  printf("how long: ");
  _isoc99_scanf("%d", &v0);
  if ( v1 <= 9 && number <= 10 )
  {
    if ( v0 > 0xFF )
    {
      puts("too large!");
    }
    else
    {
      v2 = v1;
      chunk[v2] = (char *)malloc((int)v0);
      size[v2] = (int)v0;
      ++number;
      puts("Done!\n");
    }
  }
}