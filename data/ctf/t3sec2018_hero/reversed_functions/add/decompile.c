void add()
{
  char *v0;
  int i;

  for ( i = 0; i <= 9 && name[i]; ++i )
    ;
  if ( i == 10 )
  {
    puts("You can't add more heros!");
  }
  else
  {
    name[i] = (char *)malloc(0x68uLL);
    power[i] = (char *)malloc(0xF8uLL);
    puts("What's your hero's name:");
    v0 = name[i];
    v0[read(0, v0, 0x68uLL)] = 0;
    puts("What's your hero's power:");
    read(0, power[i], 0xF8uLL);
    puts("Done!");
  }
}