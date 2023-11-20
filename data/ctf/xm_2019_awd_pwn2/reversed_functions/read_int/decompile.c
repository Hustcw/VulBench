int read_int()
{
  char nptr[8]; // [rsp+0h] [rbp-20h] BYREF
  __int64 v2; // [rsp+8h] [rbp-18h]
  int v3; // [rsp+10h] [rbp-10h]
  unsigned __int64 v4; // [rsp+18h] [rbp-8h]

  v4 = __readfsqword(0x28u);
  *(_QWORD *)nptr = 0LL;
  v2 = 0LL;
  v3 = 0;
  read_str(nptr, 16);
  return atoi(nptr);
}