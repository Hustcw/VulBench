void __fastcall __noreturn main(int a1, char **a2, char **a3)
{
  int v3;

  v3 = 0;
  setbuf(stdin, 0LL);
  setbuf(stdout, 0LL);
  setbuf(stderr, 0LL);
  sub_11F0();
  while ( 1 )
  {
    while ( 1 )
    {
      sub_124B();
      _isoc99_scanf("%d", &v3);
      fgetc(stdin);
      if ( v3 != 1 )
        break;
      sub_F29();
    }
    if ( v3 > 1 )
    {
      if ( v3 == 2 )
      {
        sub_10CD();
      }
      else
      {
        if ( v3 != 3 )
          goto LABEL_13;
        sub_115A();
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
