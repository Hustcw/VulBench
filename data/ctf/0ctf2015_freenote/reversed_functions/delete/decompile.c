void delete()
{
  int num;

  if ( note_stru->count <= 0 )
  {
    puts("No notes yet.");
  }
  else
  {
    printf("Note number: ");
    num = read_num();
    if ( num >= 0 && num < note_stru->limit )
    {
      --note_stru->count;
      note_stru->note_list[num].used = 0LL;
      note_stru->note_list[num].field_8 = 0LL;
      free(note_stru->note_list[num].content);
      puts("Done.");
    }
    else
    {
      puts("Invalid number!");
    }
  }
}