void __fastcall __noreturn main(int a1, char **a2, char **a3)
{
  int v3; // eax

  while ( 1 )
  {
    while ( 1 )
    {
      v3 = read_int();
      if ( v3 != 2 )
        break;
      show_name();
    }
    if ( v3 > 2 )
    {
      if ( v3 == 3 )
      {
        delete_name();
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
      add_name();
    }
  }
}