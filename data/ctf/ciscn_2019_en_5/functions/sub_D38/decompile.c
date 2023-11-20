unsigned __int64 sub_D38()
{
  unsigned __int64 v1;

  v1 = __readfsqword(0x28u);
  puts("1. add");
  puts("2. show");
  puts("3. remove");
  puts("4. exit");
  printf("choice> ");
  return __readfsqword(0x28u) ^ v1;
}
