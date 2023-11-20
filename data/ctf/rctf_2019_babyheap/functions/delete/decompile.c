unsigned __int64 delete()
{
  unsigned int v1;
  unsigned __int64 v2;

  v2 = __readfsqword(0x28u);
  printf("Index: ");
  v1 = get_int();
  if ( v1 <= 0xF && *((_QWORD *)ptrs + 2 * (int)v1) )
  {
    free(*((void **)ptrs + 2 * (int)v1));
    *((_QWORD *)ptrs + 2 * (int)v1) = 0LL;
    *((_DWORD *)ptrs + 4 * (int)v1 + 2) = 0;
    puts("Delete success :)");
  }
  else
  {
    puts("Invalid index :(");
  }
  return __readfsqword(0x28u) ^ v2;
}
