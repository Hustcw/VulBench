unsigned __int64 delete_note()
{
  unsigned int v1;
  unsigned __int64 v2;

  v2 = __readfsqword(0x28u);
  puts("Enter an index:");
  __isoc99_scanf("%d", &v1);
  if ( v1 <= 0xA && note[v1].content )
  {
    free((void *)note[v1].content);
    note[v1].content = 0LL;
    note[v1].size = 0;
    --counts;
    puts("Done!");
  }
  else
  {
    puts("You can't hack me!");
  }
  return __readfsqword(0x28u) ^ v2;
}