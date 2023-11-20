void __noreturn getflag()
{
  if ( *(_DWORD *)flag == -1 )
  {
    puts("You are thinking peach");
    exit(0);
  }
  system("/bin/cat flag");
  exit(0);
}
