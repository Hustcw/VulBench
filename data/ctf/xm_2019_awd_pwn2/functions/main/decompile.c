void __fastcall __noreturn main(__int64 a1, char **a2, char **a3)
{
  int v3;

  sub_11D5();
  while ( 1 )
  {
    while ( 1 )
    {
      v3 = sub_15C0(a1, a2);
      if ( v3 != 2 )
        break;
      sub_1470();
    }
    if ( v3 > 2 )
    {
      if ( v3 == 3 )
      {
        sub_151E();
      }
      else if ( v3 == 4 )
      {
        exit(0);
      }
    }
    else if ( v3 == 1 )
    {
      sub_134D();
    }
  }
}
