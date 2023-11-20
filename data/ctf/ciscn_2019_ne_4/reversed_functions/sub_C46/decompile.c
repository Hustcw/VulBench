void sub_C46()
{
  int i;
  int v1;
  int v2;
  char *v3;

  for ( i = 0; i <= 15; ++i )
  {
    if ( !games[i].used )
    {
      printf("size: ");
      v2 = sub_BE0(v1);
      if ( v2 > 0 )
      {
        if ( v2 > 4096 )
          v2 = 4096;
        v3 = (char *)calloc(v2, 1uLL);
        if ( !v3 )
          exit(-1);
        games[i].used = 1;
        games[i].size = v2;
        games[i].content = v3;
        printf("The lowbits of heap leak check : %x\n", (__int64)games[i].content & 0xFFF);
        printf("the index of ticket is %d \n", (unsigned int)i);
      }
      return;
    }
  }
}