unsigned __int64 sub_AC0()
{
  int v1;
  int i;
  void *s;
  unsigned __int64 v4;

  v4 = __readfsqword(0x28u);
  v1 = 0;
  for ( i = 0; qword_2020A0[i]; ++i )
    ;
  if ( i <= 9 )
  {
    puts("Input the size:");
    _isoc99_scanf("%d", &v1);
    if ( v1 <= 0 || v1 > 1023 )
    {
      puts("Size error!");
    }
    else
    {
      s = malloc(v1);
      if ( s )
      {
        memset(s, 0, v1);
        qword_2020A0[i] = s;
        dword_202060[i] = v1;
        puts("Input the content:");
        read(0, s, v1);
        puts("Add success");
      }
    }
  }
  else
  {
    puts("The list is full");
  }
  return __readfsqword(0x28u) ^ v4;
}
