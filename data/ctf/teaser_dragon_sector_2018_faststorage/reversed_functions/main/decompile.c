void __fastcall __noreturn main(int a1, char **a2, char **a3)
{
  int v3;

  v3 = 0;
  while ( 1 )
  {
    while ( 1 )
    {
      menu();
      _isoc99_scanf("%d", &v3);
      fgetc(stdin);
      if ( v3 != 1 )
        break;
      add_entry();
    }
    if ( v3 > 1 )
    {
      if ( v3 == 2 )
      {
        print_entry();
      }
      else
      {
        if ( v3 != 3 )
          goto LABEL_13;
        edit_entry();
      }
    }
    else
    {
      if ( !v3 )
        exit(0);
LABEL_13:
      puts("e?");
    }
  }
}