void init2()
{
  int i;

  note_stru = (NoteList *)malloc(0x1810uLL);
  note_stru->limit = 256LL;
  note_stru->count = 0LL;
  for ( i = 0; i <= 255; ++i )
  {
    note_stru->note_list[i].used = 0LL;
    note_stru->note_list[i].field_8 = 0LL;
    note_stru->note_list[i].content = 0LL;
  }
}