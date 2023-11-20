void list()
{
  unsigned int i;

  if ( note_stru->count <= 0 )
  {
    puts("You need to create some new notes first.");
  }
  else
  {
    for ( i = 0; (int)i < note_stru->limit; ++i )
    {
      if ( note_stru->note_list[i].used == 1 )
        printf("%d. %s\n", i, note_stru->note_list[i].content);
    }
  }
}