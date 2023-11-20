void __cdecl magic()
{
  size_t addr[2];

  addr[1] = __readfsqword(0x28u);
  if ( magic_times )
  {
    puts("no magic any more!");
  }
  else
  {
    puts("addr: ");
    __isoc99_scanf("%llu", addr);
    *(_QWORD *)addr[0] = 8193LL;
  }
  puts("success");
}