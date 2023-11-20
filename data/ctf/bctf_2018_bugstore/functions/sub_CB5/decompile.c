unsigned __int64 sub_CB5()
{
  char v1[40];
  unsigned __int64 v2;

  v2 = __readfsqword(0x28u);
  if ( byte_202049 )
  {
    puts("ain't it cool, bye now");
  }
  else
  {
    byte_202049 = 1;
    sub_BC6(v1, 0x200u);
  }
  return __readfsqword(0x28u) ^ v2;
}
