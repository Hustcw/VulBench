int sub_8048656()
{
  char buf[8]; // [esp+4h] [ebp-14h] BYREF
  unsigned int v2; // [esp+Ch] [ebp-Ch]

  v2 = __readgsdword(0x14u);
  read(0, buf, 8u);
  return atol(buf);
}