void sub_E5B()
{
  unsigned __int64 v0;
  char s[24];
  unsigned __int64 v2;

  v2 = __readfsqword(0x28u);
  while ( 1 )
  {
    while ( 1 )
    {
      puts("EMMmmm, you will be a rich man!");
      fgets(s, 24, stdin);
      v0 = strtoul(s, 0LL, 0);
      if ( v0 != 2 )
        break;
      sub_E48();
    }
    if ( v0 == 3 )
      break;
    if ( v0 == 1 )
      sub_D81();
  }
}