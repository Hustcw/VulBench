void __cdecl add()
{
  int sz_choice;
  int i;
  int sz;
  unsigned __int64 v3;

  v3 = __readfsqword(0x28u);
  for ( i = 0; i <= 2 && note_ptr[i]; ++i )
    ;
  if ( i == 3 )
  {
    puts("Error: can not add any more");
  }
  else
  {
    puts("add size: ");
    puts("1. 0x20");
    puts("2. 0x400");
    sz = 0;
    sz_choice = 0;
    __isoc99_scanf("%d", &sz_choice);
    if ( sz_choice == 1 )
      sz = 96;
    else
      sz = 1024;
    if ( sz == 1024 )
    {
      if ( add_times[0] )
      {
        puts("Error: just can malloc chunk whose size is 0x400 once");
        exit(0);
      }
      ++add_times[0];
    }
    note_ptr[i] = (char *)malloc(sz);
    memset(note_ptr[i], 0, 0x10uLL);
    puts("content: ");
    read(0, note_ptr[i], (unsigned int)sz);
    puts("success");
  }
}
