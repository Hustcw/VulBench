unsigned __int64 sub_C1D()
{
  unsigned int v1;
  unsigned __int64 v2;

  v2 = __readfsqword(0x28u);
  puts("Input the index:");
  v1 = 0;
  _isoc99_scanf("%d", &v1);
  if ( v1 <= 9 && qword_2020A0[v1] )
  {
    free((void *)qword_2020A0[v1]);
    qword_2020A0[v1] = 0LL;
    dword_202060[v1] = 0;
    puts("Delete success");
  }
  else
  {
    puts("Delete fail");
  }
  return __readfsqword(0x28u) ^ v2;
}
