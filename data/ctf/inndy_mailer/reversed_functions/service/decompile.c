void service()
{
  int v0;

  root = &helloworld;
  memcpy(helloworld.content, "Hello, World", 0xCu);
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
  puts("Bye");
}