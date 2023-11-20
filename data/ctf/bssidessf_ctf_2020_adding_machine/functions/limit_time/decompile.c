unsigned __int64 __fastcall limit_time(int a1)
{
  struct rlimit rlimits;
  unsigned __int64 v3;

  v3 = __readfsqword(0x28u);
  rlimits.rlim_cur = a1;
  rlimits.rlim_max = a1;
  if ( setrlimit(RLIMIT_CPU, &rlimits) )
    _exit(1);
  return __readfsqword(0x28u) ^ v3;
}
