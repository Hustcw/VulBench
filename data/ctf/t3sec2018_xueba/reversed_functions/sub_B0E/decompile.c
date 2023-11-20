void sub_B0E()
{
  int v0;
  unsigned int i;
  unsigned __int64 v2;

  v2 = __readfsqword(0x28u);
  if ( note_count > 5 )
  {
    puts("You can't add any more notes!");
    exit(0);
  }
  for ( i = 0; i <= 4 && notes[i].used; ++i )
    ;
  puts("How long is your note?");
  _isoc99_scanf("%u", &v0);
  if ( i > 0x80 )
  {
    puts("Too long!");
    exit(0);
  }
  notes[i].used = 1LL;
  notes[i].content = (char *)malloc((unsigned int)(v0 + 1));
  puts("Input your note name and note content:");
  read_str(notes[i].name, 0x15u);
  read_str(notes[i].content, v0);
  ++note_count;
  puts("Done!");
}