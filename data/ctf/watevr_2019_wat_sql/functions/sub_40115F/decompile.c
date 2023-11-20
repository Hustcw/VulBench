void sub_40115F()
{
  while ( 1 )
  {
    while ( 1 )
    {
      printf("%s", "Query: ");
      fflush(stdout);
      fgets(haystack, 20, stdin);
      if ( !strstr(haystack, "read") )
        break;
      if ( ++dword_602100 > 2 )
      {
        printf("You have exhausted the request limit for your wat-sql demo!");
        __asm { retn }
      }
      sub_400E30();
    }
    if ( strstr(haystack, "write") )
    {
      sub_400FB7();
      if ( ++dword_602100 > 2 )
      {
        printf("You have exhausted the request limit for your wat-sql demo!");
        __asm { retn }
      }
    }
    else
    {
      puts("Unrecognised command!");
    }
  }
}
