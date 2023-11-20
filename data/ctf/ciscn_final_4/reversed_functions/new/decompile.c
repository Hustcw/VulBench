void new()
{
  unsigned int v0;
  int i;
  unsigned __int64 v2;

  v2 = __readfsqword(0x28u);
  for ( i = 0; i <= 31 && note[i]; ++i )
    ;
  if ( i == 32 )
  {
    puts("full!");
  }
  else
  {
    puts("size?");
    _isoc99_scanf("%d", &v0);
    if ( v0 < 0x1001 )
    {
      note[i] = (char *)malloc((int)v0);
      note_size[i] = v0;
      puts("content?");
      read(0, note[i], (int)v0);
    }
    else
    {
      puts("invalid size");
    }
  }
}