void mwrite()
{
  unsigned int v0;
  unsigned __int64 v1;

  v1 = __readfsqword(0x28u);
  puts("index ?");
  _isoc99_scanf("%d", &v0);
  if ( v0 <= 0x1F && note[v0] )
    puts(note[v0]);
  else
    puts("invalid index");
}