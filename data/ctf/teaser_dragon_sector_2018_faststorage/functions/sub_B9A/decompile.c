_QWORD *__fastcall sub_B9A(int a1, __int64 a2, __int64 a3)
{
  _QWORD *result;
  _QWORD *v5;

  v5 = malloc(0x18uLL);
  if ( !v5 )
    sub_A70();
  v5[1] = a2;
  v5[2] = a3;
  *v5 = qword_202140[a1];
  result = qword_202140;
  qword_202140[a1] = v5;
  return result;
}
