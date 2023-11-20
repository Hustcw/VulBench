int __cdecl __noreturn main(int argc, const char **argv, const char **envp)
{
  int v3;

  initialize();
  while ( 1 )
  {
    while ( 1 )
    {
      show_menu();
      v3 = read_int();
      if ( v3 != 2 )
        break;
      grimoire_read();
    }
    if ( v3 > 2 )
    {
      if ( v3 == 3 )
      {
        grimoire_edit();
      }
      else if ( v3 == 4 )
      {
        grimoire_close();
      }
      else
      {
LABEL_13:
        puts("Invalid choice.");
      }
    }
    else
    {
      if ( v3 != 1 )
        goto LABEL_13;
      grimoire_open();
    }
  }
}