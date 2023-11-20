__int64 sub_C1A()
{
  _QWORD *v0;
  __int64 *v1;
  __int64 result;

  printf("x0 = ");
  v0 = (_QWORD *)qword_202068;
  *v0 = sub_B1A();
  printf("x1 = ");
  v1 = (__int64 *)(qword_202068 + 8);
  result = sub_B1A();
  *v1 = result;
  return result;
}
