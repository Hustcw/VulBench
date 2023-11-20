unsigned __int64 ask()
{
  unsigned __int64 v1;

  v1 = __readfsqword(0x28u);
  puts("Menu:");
  puts("1. add edge");
  puts("2. find path");
  puts("3. get flag");
  puts("4. exit:");
  return __readfsqword(0x28u) ^ v1;
}
