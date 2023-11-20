void sub_C0E()
{
  int v0;
  int i;
  unsigned __int64 v2;

  v2 = __readfsqword(0x28u);
  for ( i = 0; i <= 15 && byte_2020C0[i]; ++i )
    ;
  if ( i <= 15 )
  {
    printf("length: ");
    __isoc99_scanf("%d", &v0);
    if ( v0 > 127 && v0 <= 0x10000 )
    {
      byte_2020C0[i] = (char *)malloc(v0);
      if ( !byte_2020C0[i] )
      {
        puts("malloc failed.");
        exit(-1);
      }
      memset(byte_2020C0[i], 0, v0);
      puts("your note:");
      sub_B20(byte_2020C0[i], (unsigned int)v0);
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
}