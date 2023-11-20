int __cdecl __noreturn main(int argc, const char **argv, const char **envp)
{
  int v3;

  setvbuf(stdout, 0, 2, 0);
  setvbuf(_bss_start, 0, 2, 0);
  while ( 1 )
  {
    while ( 1 )
    {
      menu();
      v3 = read_int();
      if ( v3 != 2 )
        break;
      show_note();
    }
    if ( v3 > 2 )
    {
      if ( v3 == 3 )
      {
        del_note();
      }
      else
      {
        if ( v3 == 4 )
          exit(0);
LABEL_13:
        puts("Invalid choice");
      }
    }
    else
    {
      if ( v3 != 1 )
        goto LABEL_13;
      add_note();
    }
  }
}
