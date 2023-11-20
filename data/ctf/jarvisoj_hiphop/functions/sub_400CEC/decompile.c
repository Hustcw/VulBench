_QWORD *__fastcall sub_400CEC(_QWORD *a1)
{
  int v1;
  _QWORD *result;

  v1 = ((rand() % 1000) << 16) % 100;
  result = a1;
  *a1 = v1;
  return result;
}
