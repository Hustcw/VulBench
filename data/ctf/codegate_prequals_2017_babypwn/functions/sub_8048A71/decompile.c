unsigned int sub_8048A71()
{
  int v1;
  char v2[40];
  unsigned int v3;

  v3 = __readgsdword(0x14u);
  memset(v2, 0, sizeof(v2));
  while ( 1 )
  {
    while ( 1 )
    {
      while ( 1 )
      {
        sub_80488B1("\n===============================\n");
        sub_80488B1("1. Echo\n");
        sub_80488B1("2. Reverse Echo\n");
        sub_80488B1("3. Exit\n");
        sub_80488B1("===============================\n");
        v1 = sub_804895A();
        if ( v1 != 1 )
          break;
        sub_80488B1("Input Your Message : ");
        sub_8048907(v2, 0x64u);
        sub_80488B1(v2);
      }
      if ( v1 != 2 )
        break;
      sub_80488B1("Input Your Message : ");
      sub_8048907(v2, 0x64u);
      sub_80489C8(v2);
      sub_80488B1(v2);
    }
    if ( v1 == 3 )
      break;
    sub_80488B1("\n[!] Wrong Input\n");
  }
  return __readgsdword(0x14u) ^ v3;
}
