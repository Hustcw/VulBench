unsigned __int64 call_realloc()
{
  size_t size;
  unsigned __int64 v2;

  v2 = __readfsqword(0x28u);
  printf("Size: ");
  __isoc99_scanf("%ld", &size);
  getchar();
  ptr_r = realloc(ptr_r, size);
  printf("Data: ");
  read(0, ptr_r, size);
  return __readfsqword(0x28u) ^ v2;
}
