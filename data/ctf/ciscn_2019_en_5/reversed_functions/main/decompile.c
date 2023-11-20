void __fastcall __noreturn main(__int64 a1, char **a2, char **a3)
{
  int v3; // eax

  init_0();
  while ( 1 )
  {
    while ( 1 )
    {
      menu();
      v3 = read_int();
      if ( v3 != 2 )
        break;
      show();
    }
    if ( v3 > 2 )
    {
      if ( v3 == 3 )
      {
        remove();
      }
      else
      {
        if ( v3 == 4 )
          quit();
LABEL_13:
        puts("Invalid option");
      }
    }
    else
    {
      if ( v3 != 1 )
        goto LABEL_13;
      add();
    }
  }
}