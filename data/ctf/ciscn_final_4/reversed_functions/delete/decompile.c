void delete()
{
  unsigned int v0;
  unsigned __int64 v1;

  v1 = __readfsqword(0x28u);
  puts("please don't patch this function!! I will check it!!");
  puts("index ?");
  _isoc99_scanf("%d", &v0);
  if ( v0 <= 0x1F && note[v0] )
    free(note[v0]);
  else
    puts("invalid index");
}