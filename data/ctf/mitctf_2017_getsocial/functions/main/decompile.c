void __cdecl __noreturn main()
{
  char s[256];
  int v1;

  sub_80485FB();
  sub_8048853();
  while ( 1 )
  {
    while ( 1 )
    {
      printf("Enter your command: ");
      fgets(s, 256, stdin);
      if ( s[0] != a0[0] )
        break;
      sub_80486DC();
    }
    if ( s[0] == a1[0] )
    {
      sub_8048742();
    }
    else if ( s[0] == a2[0] )
    {
      printf("Which tweet would you like to overwrite? ");
      fgets(s, 256, stdin);
      v1 = atoi(s);
      if ( v1 < (unsigned int)dword_8049FB4 )
      {
        printf("Enter a new tweet: ");
        fgets(s, 256, stdin);
        s[strcspn(s, "\n")] = 0;
        sub_8048680(v1, s);
      }
      else
      {
        puts("Invalid tweet index.");
      }
    }
    else if ( s[0] == a3[0] )
    {
      printf("Enter a new tweet: ");
      fgets(s, 256, stdin);
      s[strcspn(s, "\n")] = 0;
      sub_80487A7(s);
    }
  }
}
