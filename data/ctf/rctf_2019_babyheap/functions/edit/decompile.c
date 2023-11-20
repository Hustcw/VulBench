unsigned __int64 edit()
{
  unsigned int v1;
  unsigned __int64 v2;

  v2 = __readfsqword(0x28u);
  printf("Index: ");
  v1 = get_int();
  if ( v1 <= 0xF && *((_QWORD *)ptrs + 2 * (int)v1) )
  {
    printf("Content: ");
    *(_BYTE *)(*((_QWORD *)ptrs + 2 * (int)v1)
             + (int)read_n(*((void **)ptrs + 2 * (int)v1), *((_DWORD *)ptrs + 4 * (int)v1 + 2))) = 0;
    puts("Edit success :)");
  }
  else
  {
    puts("Invalid index :(");
  }
  return __readfsqword(0x28u) ^ v2;
}
