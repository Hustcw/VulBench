_DWORD *__cdecl new_mail(int a1)
{
  _DWORD *result;

  result = malloc(a1 + 72);
  *result = 0;
  result[17] = a1;
  return result;
}
