void add()
{
  int v0;
  int i;
  void *s;
  unsigned __int64 v3;

  v3 = __readfsqword(0x28u);
  v0 = 0;
  for ( i = 0; notes[i]; ++i )
    ;
  if ( i <= 9 )
  {
    puts("Input the size:");
    _isoc99_scanf("%d", &v0);
    if ( v0 <= 0 || v0 > 1023 )
    {
      puts("Size error!");
    }
    else
    {
      s = malloc(v0);
      if ( s )
      {
        memset(s, 0, v0);
        notes[i] = (char *)s;
        size[i] = v0;
        puts("Input the content:");
        read(0, s, v0);
        puts("Add success");
      }
    }
  }
  else
  {
    puts("The list is full");
  }
}