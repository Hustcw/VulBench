_QWORD *sub_400A49()
{
  _QWORD *result;
  int i;

  qword_6020A8 = (__int64)malloc(0x1810uLL);
  *(_QWORD *)qword_6020A8 = 256LL;
  result = (_QWORD *)qword_6020A8;
  *(_QWORD *)(qword_6020A8 + 8) = 0LL;
  for ( i = 0; i <= 255; ++i )
  {
    *(_QWORD *)(qword_6020A8 + 24LL * i + 16) = 0LL;
    *(_QWORD *)(qword_6020A8 + 24LL * i + 24) = 0LL;
    result = (_QWORD *)(qword_6020A8 + 24LL * i + 32);
    *result = 0LL;
  }
  return result;
}
