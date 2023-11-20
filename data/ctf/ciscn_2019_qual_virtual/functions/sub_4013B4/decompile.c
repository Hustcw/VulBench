_DWORD *__fastcall sub_4013B4(int a1)
{
  _DWORD *ptr;
  void *s;

  ptr = malloc(0x10uLL);
  if ( !ptr )
    return 0LL;
  s = malloc(8LL * a1);
  if ( s )
  {
    memset(s, 0, 8LL * a1);
    *(_QWORD *)ptr = s;
    ptr[2] = a1;
    ptr[3] = -1;
    return ptr;
  }
  else
  {
    free(ptr);
    return 0LL;
  }
}
