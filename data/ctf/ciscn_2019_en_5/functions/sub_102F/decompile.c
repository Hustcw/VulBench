unsigned __int64 sub_102F()
{
  unsigned int v1;
  unsigned __int64 v2;

  v2 = __readfsqword(0x28u);
  printf("index> ");
  v1 = sub_CD3();
  if ( v1 <= 0x13 && qword_202100[v1] )
    puts((const char *)qword_202100[v1]);
  else
    puts("invalid index");
  return __readfsqword(0x28u) ^ v2;
}
