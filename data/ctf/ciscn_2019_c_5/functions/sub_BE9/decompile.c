unsigned __int64 sub_BE9()
{
  int v0;
  int v2;
  unsigned __int64 v3;

  v3 = __readfsqword(0x28u);
  if ( dword_20204C > 16 )
    puts("Enough!");
  puts("Please input the size of story: ");
  _isoc99_scanf("%d", &v2);
  *((_DWORD *)&unk_202060 + 4 * dword_20204C) = v2;
  v0 = dword_20204C;
  *((_QWORD *)&unk_202068 + 2 * v0) = malloc(v2);
  puts("please inpute the story: ");
  read(0, *((void **)&unk_202068 + 2 * dword_20204C), v2);
  ++dword_20204C;
  puts("Done!");
  return __readfsqword(0x28u) ^ v3;
}
