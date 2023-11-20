unsigned __int64 sub_D3F()
{
  unsigned int v1;
  unsigned __int64 v2;

  v2 = __readfsqword(0x28u);
  puts("Index:");
  _isoc99_scanf("%u", &v1);
  if ( *((_QWORD *)&unk_202070 + 4 * v1) == 1LL )
  {
    free(*((void **)&unk_202078 + 4 * v1));
    *((_QWORD *)&unk_202070 + 4 * v1) = 0LL;
    --dword_202050;
    puts("Done!");
  }
  else
  {
    puts("No such note!");
  }
  return __readfsqword(0x28u) ^ v2;
}
