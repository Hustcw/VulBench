unsigned __int64 grimoire_edit()
{
  unsigned __int16 v1;
  unsigned __int16 v2;
  char buf[520];
  unsigned __int64 v4;

  v4 = __readfsqword(0x28u);
  if ( init )
  {
    printf("Offset: ");
    v2 = read_int();
    if ( v2 <= 0x200u )
    {
      printf("Text: ");
      v1 = read(0, buf, 0x200uLL);
      if ( !v1 )
      {
        error("read", "Received nothing");
        exit(1);
      }
      if ( buf[v1 - 1] == 10 )
        --v1;
      buf[v1] = 0;
      memcpy(&text[v2], buf, v1);
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
  return __readfsqword(0x28u) ^ v4;
}
