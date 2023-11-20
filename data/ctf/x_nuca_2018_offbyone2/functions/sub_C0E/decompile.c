unsigned __int64 sub_C0E()
{
  signed int v1;
  int i;
  unsigned __int64 v3;

  v3 = __readfsqword(0x28u);
  for ( i = 0; i <= 15 && *((_QWORD *)&unk_2020C0 + i); ++i )
    ;
  if ( i <= 15 )
  {
    printf("length: ");
    __isoc99_scanf("%d", &v1);
    if ( v1 > 127 && v1 <= 0x10000 )
    {
      *((_QWORD *)&unk_2020C0 + i) = malloc(v1);
      if ( !*((_QWORD *)&unk_2020C0 + i) )
      {
        puts("malloc failed.");
        exit(-1);
      }
      memset(*((void **)&unk_2020C0 + i), 0, v1);
      puts("your note:");
      sub_B20(*((_QWORD *)&unk_2020C0 + i), v1);
      puts("done.");
    }
    else
    {
      puts("invalid size");
    }
  }
  else
  {
    puts("you can't add anymore.");
  }
  return __readfsqword(0x28u) ^ v3;
}
