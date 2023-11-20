int sub_C62()
{
  if ( byte_202260 )
    return puts("ain't it cool, bye now");
  byte_202260 = 1;
  read(0, unk_202060, 0x200uLL);
  return _printf_chk(1LL, &unk_202060);
}