void grimoire_edit()
{
  unsigned __int16 v0;
  unsigned __int16 v1;
  char buf[520];

  if ( init )
  {
    printf("Offset: ");
    v1 = read_int();
    if ( v1 <= 0x200u )
    {
      printf("Text: ");
      v0 = read(0, buf, 0x200uLL);
      if ( !v0 )
      {
        error("read", "Received nothing");
        exit(1);
      }
      if ( buf[v0 - 1] == 10 )
        --v0;
      buf[v0] = 0;
      memcpy(&text[v1], buf, v0);
    }
    else
    {
      puts("You can't add a new page.");
    }
  }
  else
  {
    puts("You must read the book before editing it.");
  }
}