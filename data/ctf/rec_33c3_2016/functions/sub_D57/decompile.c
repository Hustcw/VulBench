unsigned int sub_D57()
{
  unsigned int result;
  unsigned int v1;

  v1 = __readgsdword(0x14u);
  sub_CDB();
  result = __readgsdword(0x14u) ^ v1;
  if ( result )
    sub_1030();
  return result;
}
