void __cdecl show()
{
  int i;
  unsigned __int64 v1;

  v1 = __readfsqword(0x28u);
  puts("index: ");
  i = 0;
  __isoc99_scanf("%d", &i);
  if ( (unsigned int)i <= 2 && note_ptr[i] )
  {
    puts("content: ");
    puts(note_ptr[i]);
  }
  else
  {
    puts("Error");
  }
  puts("success");
}