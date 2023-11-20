void __fastcall __noreturn main(int a1, char **a2, char **a3)
{
  int v3;

  sub_400903();
  while ( 1 )
  {
    while ( 1 )
    {
      sub_400B76();
      v3 = sub_400941();
      if ( v3 != 2 )
        break;
      sub_400A58();
    }
    if ( v3 > 2 )
    {
      if ( v3 == 3 )
      {
        sub_400AC7();
      }
      else
      {
        if ( v3 == 4 )
        {
          puts("Bye!");
          exit(0);
        }
LABEL_13:
        puts("Invalid Choice !");
      }
    }
    else
    {
      if ( v3 != 1 )
        goto LABEL_13;
      sub_400990();
    }
  }
}
