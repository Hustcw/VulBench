void Create()
{
  int i;
  Flag *v1;

  for ( i = 0; i <= 9 && flag_list[i]; ++i )
    ;
  if ( i == 10 )
  {
    puts("Full flag!");
  }
  else
  {
    v1 = (Flag *)malloc(0x10uLL);
    printf("size?>");
    v1->size = read_int();
    v1->content = (char *)malloc(v1->size);
    if ( !v1->content )
    {
      puts("Can not malloc!");
      exit(0);
    }
    printf("content:");
    secure_read(v1->content, v1->size);
    v1->state = 1;
    flag_list[i] = v1;
    puts("OK!");
  }
}