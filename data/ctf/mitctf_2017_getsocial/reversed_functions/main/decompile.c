void __cdecl __noreturn main()
{
  char s[256];
  int v1;

  init_0();
  menu();
  while (1)
  {
    while (1)
    {
      printf("Enter your command: ");
      fgets(s, 256, stdin);
      if (s[0] != a0[0])
        break;
      print();
    }
    if (s[0] == a1[0])
    {
      count();
    }
    else if (s[0] == a2[0])
    {
      printf("Which tweet would you like to overwrite? ");
      fgets(s, 256, stdin);
      v1 = atoi(s);
      if (v1 < (unsigned int)tweet_count)
      {
        printf("Enter a new tweet: ");
        fgets(s, 256, stdin);
        s[strcspn(s, "\n")] = 0;
        overwrite(v1, s);
      }
      else
      {
        puts("Invalid tweet index.");
      }
    }
    else if (s[0] == a3[0])
    {
      printf("Enter a new tweet: ");
      fgets(s, 256, stdin);
      s[strcspn(s, "\n")] = 0;
      compose(s);
    }
  }
}