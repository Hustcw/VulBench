void call_realloc(void)
{
  size_t size; // [rsp+0h] [rbp-10h] BYREF
  unsigned __int64 v1; // [rsp+8h] [rbp-8h]

  v1 = __readfsqword(0x28u);
  printf("Size: ");
  __isoc99_scanf("%ld", &size);
  getchar();
  ptr_r = realloc(ptr_r, size);
  printf("Data: ");
  read(0, ptr_r, size);
}