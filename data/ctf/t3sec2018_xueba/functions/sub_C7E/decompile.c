unsigned __int64 sub_C7E()
{
  unsigned int v1;
  unsigned __int64 v2;

  v2 = __readfsqword(0x28u);
  puts("Index:");
  _isoc99_scanf("%u", &v1);
  if ( *((_QWORD *)&unk_202070 + 4 * v1) == 1LL )
    printf("Name %s\nContent:%s\n", (const char *)&unk_202060 + 32 * v1, *((const char **)&unk_202078 + 4 * v1));
  else
    puts("No such note!");
  return __readfsqword(0x28u) ^ v2;
}
