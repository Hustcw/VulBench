_BYTE *__cdecl sub_6C0(int a1, unsigned int a2)
{
  unsigned int v2;
  _BYTE *result;
  int v4;
  unsigned int i;

  v4 = getchar();
  for ( i = 0; i < a2 && v4 != -1 && v4 != 10; ++i )
  {
    v2 = i;
    *(_BYTE *)(a1 + v2) = v4;
    v4 = getchar();
  }
  *(_BYTE *)(a1 + i) = 0;
  result = (_BYTE *)(a2 - 1 + a1);
  *result = 0;
  return result;
}
