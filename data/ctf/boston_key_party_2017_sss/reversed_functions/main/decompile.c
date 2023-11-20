int __cdecl main(int argc, const char **argv, const char **envp)
{
  is_md5 = 1;
  init_key();
  while ( !(unsigned int)handle_it() )
    ;
  return 0;
}