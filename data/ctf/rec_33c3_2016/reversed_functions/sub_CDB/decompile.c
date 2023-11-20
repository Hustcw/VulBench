void sub_CDB()
{
  unsigned int result;
  void (*v1)(void);
  int v2;
  char nptr[12];
  unsigned int v4;

  v4 = __readgsdword(0x14u);
  read_str(nptr, 0xCu);
  v2 = atoi(nptr);
  if ( v2 <= 0 )
  {
    if ( v2 < 0 )
      v1 = (void (*)(void))sub_CB0;
  }
  else
  {
    v1 = (void (*)(void))sub_C85;
  }
  v1();
}