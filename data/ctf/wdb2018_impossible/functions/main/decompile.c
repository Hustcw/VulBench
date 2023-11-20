void __fastcall __noreturn main(int a1, char **a2, char **a3)
{
  int v3;
  char s[24];
  unsigned __int64 v5;

  v5 = __readfsqword(0x28u);
  sub_400842();
  while ( 1 )
  {
    while ( 1 )
    {
      printf("Guess your option:");
      memset(s, 0, 0x10uLL);
      read(0, s, 0x10uLL);
      v3 = atoi(s);
      if ( v3 != 2 )
        break;
      sub_400999();
    }
    if ( v3 > 2 )
    {
      if ( v3 == 3 )
      {
        sub_400A9B();
      }
      else if ( v3 == 9011 )
      {
        sub_4008A3();
      }
      else
      {
LABEL_13:
        puts("haha");
      }
    }
    else
    {
      if ( v3 != 1 )
        goto LABEL_13;
      sub_400A22();
    }
  }
}
