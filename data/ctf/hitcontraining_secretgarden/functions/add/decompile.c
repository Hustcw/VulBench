int add()
{
  unsigned int size;
  unsigned int size_4;
  void *s;
  void *buf;

  s = 0LL;
  buf = 0LL;
  size = 0;
  if ( (unsigned int)flowercount > 0x63 )
    return puts("The garden is overflow");
  s = malloc(0x28uLL);
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
  *((_QWORD *)s + 1) = buf;
  printf("The color of the flower :");
  __isoc99_scanf("%23s", (char *)s + 16);
  *(_DWORD *)s = 1;
  for ( size_4 = 0; size_4 <= 0x63; ++size_4 )
  {
    if ( !flowerlist[size_4] )
    {
      flowerlist[size_4] = s;
      break;
    }
  }
  ++flowercount;
  return puts("Successful !");
}
