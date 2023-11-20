unsigned __int64 new()
{
  unsigned int v1;
  int i;
  unsigned __int64 v3;

  v3 = __readfsqword(0x28u);
  for ( i = 0; i <= 31 && (&note)[i]; ++i )
    ;
  if ( i == 32 )
  {
    puts("full!");
  }
  else
  {
    puts("size?");
    _isoc99_scanf("%d", &v1);
    if ( v1 < 0x1001 )
    {
      (&note)[i] = (char *)malloc((int)v1);
      note_size[i] = v1;
      puts("content?");
      read(0, (&note)[i], (int)v1);
    }
    else
    {
      puts("invalid size");
    }
  }
  return __readfsqword(0x28u) ^ v3;
}
