unsigned __int64 show()
{
  unsigned int v1;
  unsigned __int64 v2;

  v2 = __readfsqword(0x28u);
  printf("Index: ");
  v1 = get_int();
  if ( v1 <= 0xF && *((_QWORD *)ptrs + 2 * (int)v1) )
    puts(*((const char **)ptrs + 2 * (int)v1));
  else
    puts("Invalid index :(");
  return __readfsqword(0x28u) ^ v2;
}
