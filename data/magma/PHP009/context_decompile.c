int __fastcall php_ifd_get16u(void *value, int motorola_intel)
{
  return (*((unsigned __int8 *)value + (motorola_intel == 0)) << 8) | *((unsigned __int8 *)value + (motorola_intel != 0));
}