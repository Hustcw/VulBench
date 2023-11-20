__int64 read_long()
{
  char s[40]; // [rsp+10h] [rbp-30h] BYREF
  unsigned __int64 v2; // [rsp+38h] [rbp-8h]

  v2 = __readfsqword(0x28u);
  memset(s, 0, 0x20uLL);
  if ( !(unsigned int)read(0, s, 0x20uLL) )
  {
    puts("[ERROR] read failed");
    exit(1);
  }
  return atol(s);
}