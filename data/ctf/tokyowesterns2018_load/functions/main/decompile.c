__int64 __fastcall main(__int64 a1, char **a2, char **a3)
{
  char v4[32];
  __int64 v5;
  __int64 v6;

  sub_4008A9(a1, a2, a3);
  _printf_chk(1LL, "Load file Service\nInput file name: ");
  sub_400986(&unk_601040, 128LL);
  _printf_chk(1LL, "Input offset: ");
  v6 = (int)sub_4009DB();
  _printf_chk(1LL, "Input size: ");
  v5 = (int)sub_4009DB();
  sub_4008FD(v4, &unk_601040, v6, v5);
  sub_4008D8();
  return 0LL;
}
