unsigned __int64 sub_CC7()
{
  unsigned __int64 v0;
  char s[24];
  unsigned __int64 v3;

  v3 = __readfsqword(0x28u);
  do
  {
    while ( 1 )
    {
      while ( 1 )
      {
        while ( 1 )
        {
          puts("Now, buy buy buy!");
          fgets(s, 24, stdin);
          v0 = strtoul(s, 0LL, 0);
          if ( v0 != 2 )
            break;
          sub_B47();
        }
        if ( v0 > 2 )
          break;
        if ( v0 == 1 )
          sub_9B0();
      }
      if ( v0 != 3 )
        break;
      sub_BD9();
    }
  }
  while ( v0 != 4 );
  return __readfsqword(0x28u) ^ v3;
}
