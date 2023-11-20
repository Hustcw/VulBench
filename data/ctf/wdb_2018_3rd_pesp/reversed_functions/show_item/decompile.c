int show_item()
{
  int i; // [rsp+Ch] [rbp-4h]

  if ( !num )
    return puts("No servant in the team");
  for ( i = 0; i <= 99; ++i )
  {
    if ( *((_QWORD *)&unk_6020C8 + 2 * i) )
      printf("%d : %s", (unsigned int)i, *((const char **)&unk_6020C8 + 2 * i));
  }
  return puts(byte_4010AC);
}