void __fastcall __noreturn main(__int64 a1, char **a2, char **a3)
{
  int v3;
  bool v4;

  sub_13C0(a1, a2, a3);
  sub_1460();
  while ( 1 )
  {
    do
    {
      sub_15A0();
      sub_1790();
      sub_20E0();
      v3 = unk_205B40;
    }
    while ( unk_205B40 <= 0 );
    do
    {
      free(*((void **)&unk_204040 + v3 - 1));
      v4 = unk_205B40-- == 1;
      v3 = unk_205B40;
      *((_QWORD *)&unk_204040 + unk_205B40) = 0LL;
    }
    while ( v3 >= 0 && !v4 );
  }
}
