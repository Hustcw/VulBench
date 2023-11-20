int __cdecl main(int argc, const char **argv, const char **envp)
{
  int v3;
  char nptr[256];

  init();
  while ( 1 )
  {
    dword_805817C();
    if ( !readn(nptr, 0x100u) )
      break;
    v3 = strtol(nptr, 0, 10);
    if ( !v3 )
      break;
    ((void (*)(void))dword_8058154[v3])();
  }
  do_bye();
  return 0;
}
