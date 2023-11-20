unsigned __int64 sub_B90()
{
  unsigned __int64 v1;

  v1 = __readfsqword(0x28u);
  puts(&s);
  puts("            ,-,------, ");
  puts("          _ \\(\\(_,--'  ");
  puts("     <`--'\\>/(/(__     ");
  puts("     /. .  `'` '  \\    ");
  puts("    ('')  ,        @   ");
  puts("     `-._,        /    ");
  puts("        )-)_/--( >     ");
  puts("       ''''  ''''      ");
  puts(&s);
  puts("1 . Raise a pig ");
  puts("2 . Visit pigs ");
  puts("3 . Eat a pig");
  puts("4 . Eat the whole Pig Farm");
  puts("5 . Leave the Farm");
  puts(&s);
  printf("Your choice : ");
  return __readfsqword(0x28u) ^ v1;
}
