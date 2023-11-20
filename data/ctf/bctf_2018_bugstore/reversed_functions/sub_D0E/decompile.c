int sub_D0E()
{
  int result; // eax

  if ( byte_202048 )
    return puts("ain't it cool, bye now");
  byte_202048 = 1;
  _isoc99_scanf("%llu", &qword_202040);
  result = qword_202040;
  *(_QWORD *)qword_202040 = 0x45524F5453475542LL;
  return result;
}