void sub_D3F()
{
  int v0;
  unsigned __int64 v1;

  v1 = __readfsqword(0x28u);
  puts("Index:");
  _isoc99_scanf("%u", &v0);
  if ( notes[v0].used == 1 )
  {
    free(notes[v0].content);
    notes[v0].used = 0LL;
    --note_count;
    puts("Done!");
  }
  else
  {
    puts("No such note!");
  }
}