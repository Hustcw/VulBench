unsigned __int64 menu()
{
  unsigned __int64 v1;

  v1 = __readfsqword(0x28u);
  puts("1. add     ");
  puts("2. edit    ");
  puts("3. delete  ");
  puts("4. show    ");
  puts("5. exit    ");
  puts("Choice: ");
  return __readfsqword(0x28u) ^ v1;
}
