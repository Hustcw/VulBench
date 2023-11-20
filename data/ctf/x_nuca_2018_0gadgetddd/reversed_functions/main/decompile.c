int __cdecl __noreturn main(int argc, const char **argv, const char **envp)
{
  int v3;
  char buf[264];
  unsigned __int64 v5;

  v5 = __readfsqword(0x28u);
  welcome(argc, argv, envp);
  while ( 1 )
  {
    menu();
    v3 = input_choice();
    if ( v3 == 2 )
    {
      udelete();
    }
    else if ( v3 > 2 )
    {
      if ( v3 == 3 )
      {
        ushow();
      }
      else if ( v3 == 4 )
      {
        exit(0);
      }
    }
    else if ( v3 == 1 )
    {
      uadd();
    }
    write(1, "REMARK: ", 8uLL);
    read(0, buf, 0x100uLL);
  }
}