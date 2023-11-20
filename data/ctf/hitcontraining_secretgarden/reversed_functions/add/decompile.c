void add()
{
  unsigned int size;
  unsigned int i;
  Flower *s;
  void *buf;

  s = 0LL;
  buf = 0LL;
  size = 0;
  if ( (unsigned int)flowercount > 0x63 )
  {
    puts("The garden is overflow");
  }
  else
  {
    s = (Flower *)malloc(0x28uLL);
    memset(s, 0, 0x28uLL);
    printf("Length of the name :");
    if ( (unsigned int)__isoc99_scanf("%u", &size) == -1 )
      exit(-1);
    buf = malloc(size);
    if ( !buf )
    {
      puts("Alloca error !!");
      exit(-1);
    }
    printf("The name of flower :");
    read(0, buf, size);
    s->name = (char *)buf;
    printf("The color of the flower :");
    __isoc99_scanf("%23s", s->color);
    s->used = 1;
    for ( i = 0; i <= 0x63; ++i )
    {
      if ( !flowerlist[i] )
      {
        flowerlist[i] = s;
        break;
      }
    }
    ++flowercount;
    puts("Successful !");
  }
}