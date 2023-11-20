unsigned __int64 edit_note()
{
  unsigned int v1;
  unsigned __int64 v2;

  v2 = __readfsqword(0x28u);
  puts("Enter an index:");
  __isoc99_scanf("%d", &v1);
  if ( v1 <= 0xA && *((_QWORD *)&note + 2 * (int)v1) )
  {
    puts("Enter the content: ");
    get_input(*((_QWORD *)&note + 2 * (int)v1), *((_DWORD *)&note + 4 * (int)v1 + 2));
    puts("Done!");
  }
  else
  {
    puts("You can't hack me!");
  }
  return __readfsqword(0x28u) ^ v2;
}
