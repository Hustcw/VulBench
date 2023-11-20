__int64 __fastcall main(int a1, char **a2, char **a3)
{
  char *s;
  Link *stack;
  Link *instr_list;
  Link *link;
  char *tmp;

  s = (char *)malloc(0x20uLL);
  stack = create_link(64);
  instr_list = create_link(128);
  link = create_link(64);
  tmp = (char *)malloc(0x400uLL);
  puts("Your program name:");
  read_str(s, 32);
  puts("Your instruction:");
  read_str(tmp, 1024);
  read_instr((__int64)instr_list, tmp);
  puts("Your stack data:");
  read_str(tmp, 1024);
  place_stack((__int64)stack, tmp);
  if ( (unsigned int)run(instr_list, stack, link) )
  {
    puts("-------");
    puts(s);
    print(stack);
    puts("-------");
  }
  else
  {
    puts("Your Program Crash :)");
  }
  free(tmp);
  free_(instr_list);
  free_(stack);
  free_(link);
  return 0LL;
}