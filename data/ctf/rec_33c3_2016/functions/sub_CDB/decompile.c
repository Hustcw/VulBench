unsigned int sub_CDB()
{
  unsigned int result;
  int (*v1)();
  int v2;
  char nptr[12];
  unsigned int v4;

  v4 = __readgsdword(0x14u);
  sub_6C0((int)nptr, 0xCu);
  v2 = atoi(nptr);
  if ( v2 <= 0 )
  {
    if ( v2 < 0 )
      v1 = sub_CB0;
  }
  else
  {
    v1 = sub_C85;
  }
  v1();
  result = __readgsdword(0x14u) ^ v4;
  if ( result )
    sub_1030();
  return result;
}
