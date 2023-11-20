unsigned __int64 edit_note()
{
  unsigned int v1;
  unsigned __int64 v2;

  v2 = __readfsqword(0x28u);
  puts("Enter an index:");
  __isoc99_scanf("%d", &v1);
  if ( v1 <= 0xA && note[v1].content )
  {
    puts("Enter the content: ");
    get_input(note[v1].content, (unsigned int)note[v1].size);
    puts("Done!");
  }
  else
  {
    puts("You can't hack me!");
  }
  return __readfsqword(0x28u) ^ v2;
}