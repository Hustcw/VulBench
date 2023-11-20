int __cdecl main(int argc, const char **argv, const char **envp)
{
  __gid_t v4;

  setvbuf(_bss_start, 0, 2, 0);
  v4 = getegid();
  setresgid(v4, v4, v4);
  vuln();
  return 0;
}
