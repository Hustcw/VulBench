_QWORD *__fastcall sub_400D58(_QWORD *a1)
{
  _QWORD *result;
  int v2;

  v2 = (unsigned __int16)rand();
  result = a1;
  *a1 = v2 - 1000 * ((int)((unsigned __int64)(274877907LL * v2) >> 32) >> 6);
  return result;
}
