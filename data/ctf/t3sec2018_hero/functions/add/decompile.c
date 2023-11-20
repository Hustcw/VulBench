int add()
{
  _BYTE *v1;
  int i;

  for ( i = 0; i <= 9 && name[i]; ++i )
    ;
  if ( i == 10 )
    return puts("You can't add more heros!");
  name[i] = malloc(0x68uLL);
  *((_QWORD *)&power + i) = malloc(0xF8uLL);
  puts("What's your hero's name:");
  v1 = (_BYTE *)name[i];
  v1[read(0, v1, 0x68uLL)] = 0;
  puts("What's your hero's power:");
  read(0, *((void **)&power + i), 0xF8uLL);
  return puts("Done!");
}
