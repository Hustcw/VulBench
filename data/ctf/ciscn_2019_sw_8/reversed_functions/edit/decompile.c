void __cdecl edit()
{
  int i;
  size_t size;
  unsigned __int64 v2;

  v2 = __readfsqword(0x28u);
  if ( edit_times == 2 )
  {
    puts("can not edit any more");
  }
  else
  {
    puts("index: ");
    i = 0;
    size = 0LL;
    __isoc99_scanf("%d", &i);
    if ( (unsigned int)i <= 2 && note_ptr[i] )
    {
      size = *((_QWORD *)note_ptr[i] - 1) & 0xFFFFFFFFFFFFFFE8LL;
      puts("content: ");
      read(0, note_ptr[i], size);
      ++edit_times;
    }
    else
    {
      puts("Error");
    }
  }
  puts("success");
}