int add()
{
  int result;
  unsigned int v1;
  int v2;
  int v3;
  unsigned __int64 v4;

  v4 = __readfsqword(0x28u);
  printf("Give me a book ID: ");
  _isoc99_scanf(&unk_1108, &v2);
  printf("how long: ");
  _isoc99_scanf(&unk_1108, &v1);
  result = v2;
  if ( v2 >= 0 )
  {
    result = v2;
    if ( v2 <= 9 )
    {
      result = number;
      if ( number <= 10 )
      {
        if ( v1 > 0xFF )
        {
          return puts("too large!");
        }
        else
        {
          v3 = v2;
          chunk[v3] = malloc((int)v1);
          size[v3] = (int)v1;
          ++number;
          return puts("Done!\n");
        }
      }
    }
  }
  return result;
}
