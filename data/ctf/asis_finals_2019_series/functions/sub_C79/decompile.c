__int64 sub_C79()
{
  __int64 result;
  int i;
  __int64 v2;
  __int64 v3;

  for ( i = 2; ; ++i )
  {
    result = (unsigned int)dword_202060;
    if ( i >= dword_202060 )
      break;
    v2 = *(_QWORD *)(8LL * i - 16 + qword_202068) * qword_202050;
    v3 = *(_QWORD *)(8LL * i - 8 + qword_202068) * qword_202058;
    if ( v2 > 0 && v3 > 0x7FFFFFFFFFFFFFFFLL - v2 || v2 < 0 && v3 < 0x7FFFFFFFFFFFFFFFLL - v2 )
      sub_A97("Overflow detected");
    *(_QWORD *)(8LL * i + qword_202068) = v2 + v3;
  }
  return result;
}
