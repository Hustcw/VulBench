void __fastcall __noreturn main(__int64 a1, char **a2, char **a3)
{
  int i;

  sub_AF0(a1, a2, a3);
  while ( 1 )
  {
    for ( i = sub_C70(); i != 1; i = sub_C70() )
    {
      if ( i != 2 )
        exit(0);
      sub_D90();
    }
    sub_CD0();
  }
}
