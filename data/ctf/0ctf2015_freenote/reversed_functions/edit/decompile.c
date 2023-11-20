void edit()
{
  NoteList *v0;
  int length;
  int num;

  printf("Note number: ");
  num = read_num();
  if ( num >= 0 && num < note_stru->limit && note_stru->note_list[num].used == 1 )
  {
    printf("Length of note: ");
    length = read_num();
    if ( length > 0 )
    {
      if ( length > 4096 )
        length = 4096;
      if ( length != note_stru->note_list[num].field_8 )
      {
        v0 = note_stru;
        v0->note_list[num].content = (char *)realloc(
                                               note_stru->note_list[num].content,
                                               (128 - length % 128) % 128 + length);
        note_stru->note_list[num].field_8 = length;
      }
      printf("Enter your note: ");
      read_str(note_stru->note_list[num].content, length);
      puts("Done.");
    }
    else
    {
      puts("Invalid length!");
    }
  }
  else
  {
    puts("Invalid number!");
  }
}