unsigned __int64 sub_134D()
{
  int i;
  int v2;
  unsigned __int64 v3;

  v3 = __readfsqword(0x28u);
  printf("size:");
  v2 = sub_12EC();
  if ( v2 > 0 && v2 <= 4095 )
  {
    for ( i = 0; i <= 19 && qword_4060[i]; ++i )
      ;
    if ( i <= 19 )
    {
      qword_4060[i] = malloc(v2);
      printf("content:");
      sub_1249(qword_4060[i], v2);
      puts("Done!");
    }
    else
    {
      puts("full");
    }
  }
  else
  {
    puts("invalid");
  }
  return __readfsqword(0x28u) ^ v3;
}
