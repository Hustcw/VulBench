unsigned __int64 mwrite()
{
  unsigned int v1;
  unsigned __int64 v2;

  v2 = __readfsqword(0x28u);
  puts("index ?");
  _isoc99_scanf("%d", &v1);
  if ( v1 <= 0x1F && (&note)[v1] )
    puts((&note)[v1]);
  else
    puts("invalid index");
  return __readfsqword(0x28u) ^ v2;
}
