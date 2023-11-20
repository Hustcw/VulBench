void __fastcall __noreturn main(int a1, char **a2, char **a3)
{
  int v3;

  sub_11E5();
  sub_1476();
  sub_128F();
  while ( 1 )
  {
    while ( 1 )
    {
      while ( 1 )
      {
        sub_14A1();
        v3 = sub_14F5();
        if ( v3 != 3 )
          break;
        sub_1766((__int64)&unk_4060);
      }
      if ( v3 > 3 )
        break;
      if ( v3 == 1 )
      {
        if ( qword_4018 <= 0 )
          sub_1521();
        sub_153B((__int64)&unk_4060);
        --qword_4018;
      }
      else
      {
        if ( v3 != 2 )
          goto LABEL_19;
        sub_16E8((__int64)&unk_4060);
      }
    }
    if ( v3 == 5 )
      sub_1521();
    if ( v3 < 5 )
    {
      sub_1874((__int64)&unk_4060);
    }
    else
    {
      if ( v3 != 666 )
LABEL_19:
        sub_1521();
      sub_13E3();
    }
  }
}
