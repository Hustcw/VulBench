_QWORD *__fastcall sub_400DA0(_QWORD *a1)
{
  int v1;
  _QWORD *result;
  int v3;

  v3 = rand() % 1000;
  v1 = (v3 << (rand() % 5)) % 100;
  result = a1;
  *a1 = v1;
  return result;
}
