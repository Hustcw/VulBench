__int64 Create()
{
  int i;
  int *v2;

  for ( i = 0; i <= 9 && flist[i]; ++i )
    ;
  if ( i == 10 )
  {
    puts("Full flag!");
    return 0LL;
  }
  else
  {
    v2 = (int *)malloc(0x10uLL);
    printf("size?>");
    v2[2] = read_int();
    *(_QWORD *)v2 = malloc(v2[2]);
    if ( !*(_QWORD *)v2 )
    {
      puts("Can not malloc!");
      exit(0);
    }
    printf("content:");
    secure_read(*(void **)v2, v2[2]);
    v2[3] = 1;
    flist[i] = v2;
    puts("OK!");
    return 0LL;
  }
}
