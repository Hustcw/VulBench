unsigned __int64 sub_18C0()
{
  char v1[776];
  unsigned __int64 v2;

  v2 = __readfsqword(0x28u);
  if ( getcwd(v1, 0x300uLL) )
    puts(v1);
  else
    puts("error!");
  return __readfsqword(0x28u) ^ v2;
}
