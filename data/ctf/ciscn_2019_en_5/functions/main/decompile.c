void __fastcall __noreturn main(const char *a1, char **a2, char **a3)
{
  int v3;

  sub_BD5();
  while ( 1 )
  {
    while ( 1 )
    {
      sub_D38();
      v3 = sub_CD3();
      if ( v3 != 2 )
        break;
      sub_102F();
    }
    if ( v3 > 2 )
    {
      if ( v3 == 3 )
      {
        sub_F09();
      }
      else
      {
        if ( v3 == 4 )
          sub_10D1(a1, a2);
LABEL_13:
        a1 = "Invalid option";
        puts("Invalid option");
      }
    }
    else
    {
      if ( v3 != 1 )
        goto LABEL_13;
      sub_DA7();
    }
  }
}
