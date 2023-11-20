void call_calloc(void)
{
  size_t size; // [rsp+0h] [rbp-10h] BYREF
  unsigned __int64 v1; // [rsp+8h] [rbp-8h]

  v1 = __readfsqword(0x28u);
  if ( !ptr_c )
  {
    printf("Size: ");
    __isoc99_scanf("%ld", &size);
    getchar();
    ptr_c = calloc(1uLL, size);
    printf("Data: ");
    read(0, ptr_c, size);
  }
}