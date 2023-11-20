void sub_8048A71()
{
  int v0;
  char v1[40];

  memset(v1, 0, sizeof(v1));
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
        v0 = sub_804895A();
        if ( v0 != 1 )
          break;
        sub_80488B1("Input Your Message : ");
        sub_8048907(v1, 0x64u);
        sub_80488B1(v1);
      }
      if ( v0 != 2 )
        break;
      sub_80488B1("Input Your Message : ");
      sub_8048907(v1, 0x64u);
      sub_80489C8(v1);
      sub_80488B1(v1);
    }
    if ( v0 == 3 )
      break;
    sub_80488B1("\n[!] Wrong Input\n");
  }
}