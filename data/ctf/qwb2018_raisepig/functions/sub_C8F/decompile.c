__int64 sub_C8F()
{
  unsigned int size;
  unsigned int size_4;
  void *s;
  void *buf;
  unsigned __int64 v5;

  v5 = __readfsqword(0x28u);
  s = 0LL;
  buf = 0LL;
  size = 0;
  if ( (unsigned int)dword_20202C <= 0x63 )
  {
    s = malloc(0x28uLL);
    memset(s, 0, 0x28uLL);
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
    *((_QWORD *)s + 1) = buf;
    printf("The type of the pig :");
    _isoc99_scanf("%23s", (char *)s + 16);
    *(_DWORD *)s = 1;
    for ( size_4 = 0; size_4 <= 0x63; ++size_4 )
    {
      if ( !qword_202040[size_4] )
      {
        qword_202040[size_4] = s;
        break;
      }
    }
    ++dword_20202C;
  }
  return 0LL;
}
