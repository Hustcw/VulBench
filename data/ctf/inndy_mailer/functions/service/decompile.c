int service()
{
  int v0;

  qmemcpy(&helloworld, &unk_8048AA0, 0x48u);
  root = (int)&helloworld;
  memcpy((char *)&helloworld + 72, "Hello, World", 0xCu);
  while ( 1 )
  {
    while ( 1 )
    {
      puts("0. Exit");
      puts("1. Write mail");
      puts("2. Dump mails");
      printf("Action: ");
      v0 = readint();
      if ( v0 != 1 )
        break;
      write_mail();
    }
    if ( !v0 )
      break;
    if ( v0 == 2 )
      dump_mail();
    else
      puts("Invalid choice");
  }
  return puts("Bye");
}
