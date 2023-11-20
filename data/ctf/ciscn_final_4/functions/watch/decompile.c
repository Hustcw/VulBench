void __fastcall __noreturn watch(unsigned int a1)
{
  int stat_loc;
  __int64 v2;
  char v3[120];
  __int64 v4;
  unsigned __int64 v5;

  v5 = __readfsqword(0x28u);
  wait(0LL);
  while ( 1 )
  {
    ptrace(PTRACE_SYSCALL, a1, 0LL, 0LL);
    waitpid(a1, &stat_loc, 0);
    if ( (stat_loc & 0x7F) == 0 || (char)((stat_loc & 0x7F) + 1) >> 1 > 0 || (stat_loc & 0xFF00) >> 8 != 5 )
      break;
    ptrace(PTRACE_GETREGS, a1, 0LL, v3);
    v2 = v4;
    if ( v4 == 2 || v2 == 9 || v2 == 57 || v2 == 58 || v2 == 101 )
    {
      puts("hey! what are you doing?");
      exit(-1);
    }
  }
  exit(-1);
}
