__int64 raise()
{
  unsigned int size;
  unsigned int size_4;
  Pig *s;
  void *buf;
  unsigned __int64 v5;

  v5 = __readfsqword(0x28u);
  s = 0LL;
  buf = 0LL;
  size = 0;
  if ( (unsigned int)count <= 0x63 )
  {
    s = (Pig *)malloc(0x28uLL);
    memset(s, 0, sizeof(Pig));
    printf("Length of the name :");
    if ( (unsigned int)_isoc99_scanf("%u", &size) == -1 )
      exit(-1);
    buf = malloc(size);
    if ( !buf )
    {
      puts("error !");
      exit(-1);
    }
    printf("The name of pig :");
    read(0, buf, size);
    s->name = (char *)buf;
    printf("The type of the pig :");
    _isoc99_scanf("%23s", s->type);
    s->used = 1;
    for ( size_4 = 0; size_4 <= 0x63; ++size_4 )
    {
      if ( !list[size_4] )
      {
        list[size_4] = s;
        break;
      }
    }
    ++count;
  }
  return 0LL;
}