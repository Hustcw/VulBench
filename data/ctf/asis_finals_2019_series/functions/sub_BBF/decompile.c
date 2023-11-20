__int64 sub_BBF()
{
  __int64 result;

  printf("n = ");
  dword_202060 = sub_B1A();
  qword_202068 = (__int64)malloc(8LL * dword_202060);
  result = qword_202068;
  if ( !qword_202068 )
    sub_A97("Could not allocate memory");
  return result;
}
