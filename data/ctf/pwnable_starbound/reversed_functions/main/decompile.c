int __cdecl main(int argc, const char **argv, const char **envp)
{
  int v3;
  char nptr[256];

  init();
  while ( 1 )
  {
    cur_action_ptr();
    if ( !readn(nptr, 0x100u) )
      break;
    v3 = strtol(nptr, 0, 10);
    if ( !v3 )
      break;
    ((void (*)(void))func_ptr_list[v3])();
  }
  do_bye();
  return 0;
}