void __fastcall __noreturn main(int a1, char **a2, char **a3)
{
  int v3;
  bool v4;

  init_0();
  login();
  while ( 1 )
  {
    do
    {
      get_path();
      get_input_process();
      exec_cmd();
      v3 = per_argv_size[0];
    }
    while ( per_argv_size[0] <= 0 );
    do
    {
      free(argv[v3 - 1]);
      v4 = per_argv_size[0]-- == 1;
      v3 = per_argv_size[0];
      argv[per_argv_size[0]] = 0LL;
    }
    while ( v3 >= 0 && !v4 );
  }
}