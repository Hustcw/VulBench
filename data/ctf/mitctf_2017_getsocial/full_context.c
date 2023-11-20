struct Tweet
{
  char content[140];
  struct Tweet *next;
};

char a0[2] = "0";
char a1[2] = "1";
char a2[2] = "2";
char a3[2] = "3";
Tweet aH3ll0Fr13nd = {"h3ll0 fr13nd", 0};
Tweet aWeVeBeenWaitin = {"we've been waiting for you", 0};
Tweet aWonTYouJoinUs = {"won't you join us?", 0};
Tweet *src[] =
    {&aH3ll0Fr13nd, &aWeVeBeenWaitin, &aWonTYouJoinUs};
int tweet_count;
Tweet *head;
struct Tweet
{
  char content[140];
  struct Tweet *next;
};

char a0[2] = "0";
char a1[2] = "1";
char a2[2] = "2";
char a3[2] = "3";
Tweet aH3ll0Fr13nd = {"h3ll0 fr13nd", 0};
Tweet aWeVeBeenWaitin = {"we've been waiting for you", 0};
Tweet aWonTYouJoinUs = {"won't you join us?", 0};
Tweet *src[] =
    {&aH3ll0Fr13nd, &aWeVeBeenWaitin, &aWonTYouJoinUs};
int tweet_count;
Tweet *head;

void init_0()
{
  Tweet *dest;
  int i;
  Tweet *v2;

  for (i = 0; i <= 2; ++i)
  {
    dest = (Tweet *)malloc(0x90u);
    if (!i)
    {
      head = dest;
      v2 = dest;
    }
    strcpy(dest->content, src[i]->content);
    dest->next = 0;
    v2->next = dest;
    v2 = dest;
  }
  tweet_count = 3;
}

void __cdecl overwrite(int a1, char *s)
{
  size_t v2;
  int v3;
  Tweet *dest;

  dest = head;
  v3 = 0;
  while (dest)
  {
    if (v3 == a1)
    {
      v2 = strlen(s);
      memcpy(dest, s, v2);
      return;
    }
    dest = dest->next;
    ++v3;
  }
}

void print()
{
  int v0;
  Tweet *v1;

  v1 = head;
  v0 = 0;
  puts("######");
  while (v1)
  {
    printf("Tweet %d: %s\n", v0, v1->content);
    v1 = v1->next;
    ++v0;
  }
  puts("######");
}

int count()
{
  int v1;
  Tweet *v2;

  v2 = head;
  v1 = 0;
  while (v2)
  {
    if (++v1 == 1000000)
    {
      system("cat flag");
      exit(0);
    }
    v2 = v2->next;
  }
  return printf("There are %zu tweets\n", v1);
}

void __cdecl compose(void *src)
{
  struct Tweet *dest;
  int v2;
  Tweet *v3;
  Tweet *v4;

  v4 = head;
  v3 = 0;
  v2 = 0;
  while (v4)
  {
    v3 = v4;
    v4 = v4->next;
    if ((unsigned int)++v2 > 0xF423F)
    {
      puts("[MEMORY ERROR]");
      exit(0);
    }
  }
  dest = (struct Tweet *)malloc(0x90u);
  memcpy(dest, src, 0x8Cu);
  dest->content[139] = 0;
  v3->next = dest;
  ++tweet_count;
}

int menu()
{
  puts("If you can write a million tweets, maybe I'll show you a secret.");
  return puts(
      "Commands:\n"
      "\t[0] print tweets\n"
      "\t[1] count tweets\n"
      "\t[2] overwrite an existing tweet\n"
      "\t[3] compose a new tweet");
}

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
