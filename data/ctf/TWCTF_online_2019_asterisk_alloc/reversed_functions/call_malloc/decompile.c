void __fastcall call_malloc()
{
  size_t size; // [rsp+0h] [rbp-10h] BYREF
  unsigned __int64 v1; // [rsp+8h] [rbp-8h]

  v1 = __readfsqword(0x28u);
  if ( !ptr_m )
  {
    printf("Size: ");
    __isoc99_scanf("%ld", &size);
    getchar();
    printf("Data: ");
    ptr_m = malloc(size);
    read(0, ptr_m, size);
  }
}