void sub_C7E()
{
  int v0;
  unsigned __int64 v1;

  v1 = __readfsqword(0x28u);
  puts("Index:");
  _isoc99_scanf("%u", &v0);
  if ( notes[v0].used == 1 )
    printf("Name %s\nContent:%s\n", notes[v0].name, notes[v0].content);
  else
    puts("No such note!");
}