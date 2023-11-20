int read_int()
{
  char nptr[24]; // [rsp+0h] [rbp-20h] BYREF
  unsigned __int64 v2; // [rsp+18h] [rbp-8h]

  v2 = __readfsqword(0x28u);
  read_str(nptr, 16);
  return atoi(nptr);
}