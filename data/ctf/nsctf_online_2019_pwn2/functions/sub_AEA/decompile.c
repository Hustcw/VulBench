unsigned __int64 sub_AEA()
{
  int v1;
  unsigned __int64 v2;

  v2 = __readfsqword(0x28u);
  v1 = 0;
  puts("Input the size");
  _isoc99_scanf("%d", &v1);
  if ( v1 <= 0 || v1 > 1023 )
  {
    puts("Size error!");
  }
  else
  {
    qword_202090 = malloc(v1);
    memset(qword_202090, 0, v1);
    unk_202040 = v1;
    puts("Add success");
  }
  return __readfsqword(0x28u) ^ v2;
}
