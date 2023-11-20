unsigned __int64 add()
{
  void **v0;
  int i;
  int v3;
  unsigned __int64 v4;

  v4 = __readfsqword(0x28u);
  for ( i = 0; *((_QWORD *)ptrs + 2 * i) && i <= 15; ++i )
    ;
  if ( i == 16 )
  {
    puts("You can't");
    exit(-1);
  }
  printf("Size: ");
  v3 = get_int();
  if ( v3 <= 0 || v3 > 4096 )
  {
    puts("Invalid size :(");
  }
  else
  {
    *((_DWORD *)ptrs + 4 * i + 2) = v3;
    v0 = (void **)((char *)ptrs + 16 * i);
    *v0 = calloc(v3, 1uLL);
    puts("Add success :)");
  }
  return __readfsqword(0x28u) ^ v4;
}
