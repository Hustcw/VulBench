void sub_E0B()
{
  char a1[128];
  unsigned __int64 v1;

  v1 = __readfsqword(0x28u);
  printf("Where is your destination:");
  sub_B72(a1, 128LL);
  idx = (int)sub_C37(a1);
  if ( idx == -1 )
    puts("No such place!");
  puts("Done!");
}