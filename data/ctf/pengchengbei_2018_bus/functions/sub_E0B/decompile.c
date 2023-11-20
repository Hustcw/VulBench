unsigned __int64 sub_E0B()
{
  char v1[136];
  unsigned __int64 v2;

  v2 = __readfsqword(0x28u);
  printf("Where is your destination:");
  sub_B72((__int64)v1, 128LL);
  qword_202068 = (int)sub_C37(v1);
  if ( qword_202068 == -1 )
    puts("No such place!");
  puts("Done!");
  return __readfsqword(0x28u) ^ v2;
}
