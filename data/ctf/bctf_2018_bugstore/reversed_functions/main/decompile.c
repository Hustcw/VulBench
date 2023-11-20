void __fastcall __noreturn main(__int64 a1, char **a2, char **a3)
{
  char v3[8]; // [rsp+0h] [rbp-18h] BYREF
  unsigned __int64 v4; // [rsp+8h] [rbp-10h]

  v4 = __readfsqword(0x28u);
  while ( 1 )
  {
    sub_AFE();
    read(0, v3, 2uLL);
    if ( v3[0] == 69 )
      break;
    if ( v3[0] > 69 )
    {
      if ( v3[0] == 70 )
      {
        sub_C62();
      }
      else if ( v3[0] == 83 )
      {
        sub_CB5();
      }
    }
    else if ( v3[0] == 65 )
    {
      sub_D0E();
    }
  }
  exit(0);
}