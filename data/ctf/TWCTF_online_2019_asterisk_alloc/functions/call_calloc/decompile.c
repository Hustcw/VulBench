unsigned __int64 call_calloc()
{
  size_t size;
  unsigned __int64 v2;

  v2 = __readfsqword(0x28u);
  if ( !ptr_c )
  {
    printf("Size: ");
    __isoc99_scanf("%ld", &size);
    getchar();
    ptr_c = calloc(1uLL, size);
    printf("Data: ");
    read(0, ptr_c, size);
  }
  return __readfsqword(0x28u) ^ v2;
}
