unsigned __int64 sub_401942()
{
  char v1[104];
  unsigned __int64 v2;

  v2 = __readfsqword(0x28u);
  printf("content:");
  scanf("%s", v1);
  puts("ok, thanks.");
  return __readfsqword(0x28u) ^ v2;
}
