void __fastcall __noreturn main(__int64 a1, char **a2, char **a3)
{
  int i;

  while ( 1 )
  {
    for ( i = menu_and_read_choice(); i != 1; i = menu_and_read_choice() )
    {
      if ( i != 2 )
        exit(0);
      delete();
    }
    new();
  }
}