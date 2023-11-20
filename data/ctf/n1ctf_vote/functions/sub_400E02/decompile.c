unsigned __int64 sub_400E02()
{
  int v1;
  char s[280];
  unsigned __int64 v3;

  v3 = __readfsqword(0x28u);
  memset(s, 0, 0x10AuLL);
  sub_400C52("Please enter the index: ");
  v1 = sub_400C90();
  if ( (unsigned int)v1 <= 0xF && *(&ptr + v1) )
  {
    snprintf(
      s,
      0x100uLL,
      "name: %s\ncount: %lu\ntime: %lu",
      (const char *)*(&ptr + v1) + 16,
      *(_QWORD *)*(&ptr + v1),
      *((_QWORD *)*(&ptr + v1) + 1));
    sub_400C00(s);
  }
  return __readfsqword(0x28u) ^ v3;
}
