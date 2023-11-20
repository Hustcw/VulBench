unsigned __int64 menu()
{
  unsigned __int64 v1;

  v1 = __readfsqword(0x28u);
  puts("----------Welcome to algorithm party----------");
  puts("--------------do you know SPFA----------------");
  puts("------------why is it so special--------------");
  puts("-----------O(KE) or negative loop-------------");
  puts("----------------------------------------------");
  return __readfsqword(0x28u) ^ v1;
}
