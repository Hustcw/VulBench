_DWORD *__fastcall sub_C14(int a1, char a2, char a3)
{
  _DWORD *result;

  result = dword_202040;
  dword_202040[a1] |= (1 << a2) | (1 << a3);
  return result;
}
