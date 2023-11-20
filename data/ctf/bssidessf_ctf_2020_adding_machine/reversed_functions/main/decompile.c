int __cdecl main(int argc, const char **argv, const char **envp)
{
  const char **v4;
  int v5;
  __int64 v6;
  __int64 v7;
  _QWORD v8[128];
  __int64 savedregs;

  v5 = argc;
  v4 = argv;
  qword_4100 = (__int64)&savedregs;
  qword_40F8 = (__int64)&v4;
  debug_info = (__int64)"main";
  v6 = get_long("Number of numbers to add");
  if ( v6 <= 127 )
  {
    get_data(v8, v6);
    v7 = add_nums((__int64)v8, v6);
    printf("Total is %ld\n", v7);
    return 0;
  }
  else
  {
    printf("Error, can only handle up to %d (CHAR_MAX) values!\n", 127LL);
    return 1;
  }
}