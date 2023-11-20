ssize_t cmd_set_name()
{
  ssize_t result;

  __printf_chk(1, "Enter your name: ");
  result = readn(byte_80580D0, 0x64u);
  *(_BYTE *)(result + 134578383) = 0;
  return result;
}
