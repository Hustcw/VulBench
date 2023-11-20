void __cdecl del()
{
  int i;
  unsigned __int64 v1;

  v1 = __readfsqword(0x28u);
  puts("index: ");
  i = 0;
  __isoc99_scanf("%d", &i);
  if ( (unsigned int)i <= 2 && note_ptr[i] )
  {
    if ( delete_times == 1 )
    {
      puts("Warning: delete too often.");
      puts("please note that why and when you delete these information");
      edit();
      puts("Warning: something changed when delete the information");
      puts("Warning: you can not edit any more");
      edit_times = 2;
    }
    myfree(note_ptr[i]);
    note_ptr[i] = 0LL;
    ++delete_times;
  }
  else
  {
    puts("Error");
  }
}
