void add()
{
  int v0;
  unsigned __int64 v1;

  v1 = __readfsqword(0x28u);
  v0 = 0;
  puts("Input the size");
  _isoc99_scanf("%d", &v0);
  if ( v0 <= 0 || v0 > 1023 )
  {
    puts("Size error!");
  }
  else
  {
    ptr = malloc(v0);
    memset(ptr, 0, v0);
    size = v0;
    puts("Add success");
  }
}