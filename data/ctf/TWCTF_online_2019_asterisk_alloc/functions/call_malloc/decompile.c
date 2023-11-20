unsigned __int64 call_malloc()
{
  size_t size;
  unsigned __int64 v2;

  v2 = __readfsqword(0x28u);
  if ( !ptr_m )
  {
    printf("Size: ");
    __isoc99_scanf("%ld", &size);
    getchar();
    printf("Data: ");
    ptr_m = malloc(size);
    read(0, ptr_m, size);
  }
  return __readfsqword(0x28u) ^ v2;
}
