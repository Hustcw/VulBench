_DWORD *__cdecl sub_8048680(int a1, char *s)
{
  _DWORD *result;
  size_t v3;
  int v4;
  _DWORD *dest;

  result = (_DWORD *)dword_8049FB8;
  dest = (_DWORD *)dword_8049FB8;
  v4 = 0;
  while ( dest )
  {
    if ( v4 == a1 )
    {
      v3 = strlen(s);
      return memcpy(dest, s, v3);
    }
    result = (_DWORD *)dest[35];
    dest = result;
    ++v4;
  }
  return result;
}
