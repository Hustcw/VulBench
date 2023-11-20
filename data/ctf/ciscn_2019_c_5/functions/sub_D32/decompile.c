unsigned __int64 sub_D32()
{
  int v1;
  unsigned __int64 v2;

  v2 = __readfsqword(0x28u);
  puts("Please input the index:");
  _isoc99_scanf("%d", &v1);
  free(*((void **)&unk_202068 + 2 * v1));
  puts("Done!");
  return __readfsqword(0x28u) ^ v2;
}
