unsigned __int64 sub_F09()
{
  unsigned int v1;
  unsigned __int64 v2;

  v2 = __readfsqword(0x28u);
  printf("index> ");
  v1 = sub_CD3();
  if ( v1 <= 0x13 && qword_202100[v1] )
  {
    memset((void *)qword_202100[v1], 0, qword_202060[v1]);
    free((void *)qword_202100[v1]);
    qword_202100[v1] = 0LL;
    qword_202060[v1] = 0LL;
    puts("done");
  }
  else
  {
    puts("invalid index");
  }
  return __readfsqword(0x28u) ^ v2;
}
