void new()
{
  int i;
  int num;
  char *v2;

  if ( note_stru->count < note_stru->limit )
  {
    for ( i = 0; i < note_stru->limit; ++i )
    {
      if ( !note_stru->note_list[i].used )
      {
        printf("Length of new note: ");
        num = read_num();
        if ( num > 0 )
        {
          if ( num > 4096 )
            num = 4096;
          v2 = (char *)malloc((128 - num % 128) % 128 + num);
          printf("Enter your note: ");
          read_str(v2, num);
          note_stru->note_list[i].used = 1LL;
          note_stru->note_list[i].field_8 = num;
          note_stru->note_list[i].content = v2;
          ++note_stru->count;
          puts("Done.");
        }
        else
        {
          puts("Invalid length!");
        }
        return;
      }
    }
  }
  else
  {
    puts("Unable to create new note.");
  }
}