int numposts;
int isadmin;
char adminpassword[32];
Post *posts[8];
int numposts;
int isadmin;
char adminpassword[32];
Post *posts[8];

void __cdecl readline(char *a1, int a2, FILE *a3)
{
  fgets(a1, a2, a3);
  a1[strcspn(a1, "\n")] = 0;
}

void auth()
{
  char s2[32];
  unsigned int v1;

  v1 = __readgsdword(0x14u);
  puts("Enter admin password:");
  readline(s2, 32, stdin);
  if ( !strcmp(adminpassword, s2) )
  {
    puts("Authenticated!");
    isadmin = 1;
  }
  else
  {
    puts("Wrong password!");
  }
}

void addpost()
{
  Post *v0;
  char src[32];
  unsigned int v2;

  v2 = __readgsdword(0x14u);
  if ( numposts <= 7 )
  {
    v0 = posts[numposts];
    puts("Author?");
    readline(src, 32, stdin);
    strcpy(v0->author, src);
    puts("Title?");
    readline(src, 32, stdin);
    strcpy(v0->title, src);
    puts("Body?");
    readline(src, 320, stdin);
    strcpy(v0->body, src);
    ++numposts;
  }
  else
  {
    puts("Blag is full!");
  }
}

void listposts()
{
  int i;

  for ( i = 0; i < numposts; ++i )
    printf("Post #%d: %s by %s\n", i, posts[i]->title, posts[i]->author);
}

void readpost()
{
  int v0;
  Post *v1;
  char v2[8];
  unsigned int v3;

  v3 = __readgsdword(0x14u);
  puts("Index?");
  readline(v2, 8, stdin);
  __isoc99_sscanf(v2, "%d", &v0);
  if ( v0 < numposts && v0 >= 0 )
  {
    v1 = posts[v0];
    if ( isadmin || !v1->b )
      printf("%s by %s:\n%s\n", v1->title, v1->author, v1->body);
    else
      puts("Admin only!");
  }
  else
  {
    puts("Invalid index!");
  }
}

void menu()
{
  char s1[8];
  unsigned int v1;

  v1 = __readgsdword(0x14u);
  puts(
    "Commands:\n"
    "\n"
    "list: List all posts.\n"
    "read: Read post.\n"
    "add: Add post.\n"
    "auth: Authenticate as admin.\n"
    "quit: Exactly what it says on the tin.");
  while ( 1 )
  {
    while ( 1 )
    {
      while ( 1 )
      {
        while ( 1 )
        {
          while ( 1 )
          {
            printf("> ");
            readline(s1, 8, stdin);
            if ( strcmp(s1, "list") )
              break;
            listposts();
          }
          if ( strcmp(s1, "read") )
            break;
          readpost();
        }
        if ( strcmp(s1, "add") )
          break;
        addpost();
      }
      if ( strcmp(s1, "auth") )
        break;
      auth();
    }
    if ( !strcmp(s1, "quit") )
      break;
    puts("Invalid command.");
  }
}

void readpostsfromfile()
{
  int i;
  FILE *stream;
  Post *v2;
  char s[320];
  unsigned int v4;

  v4 = __readgsdword(0x14u);
  stream = fopen("blogposts.txt", "r");
  if ( !stream )
  {
    printf("Can't read blog posts!");
    exit(1);
  }
  fgets(s, 320, stream);
  __isoc99_sscanf(s, "%d", &numposts);
  for ( i = 0; i < numposts; ++i )
  {
    v2 = posts[i];
    readline(s, 320, stream);
    __isoc99_sscanf(s, "%d", v2);
    readline(s, 320, stream);
    strcpy(v2->author, s);
    readline(s, 320, stream);
    strcpy(v2->title, s);
    readline(s, 320, stream);
    strcpy(v2->body, s);
  }
  fclose(stream);
}

void __cdecl main(int argc, const char **argv, const char **envp)
{
  int i;
  FILE *stream;

  setbuf(stdout, 0);
  setbuf(stderr, 0);
  memset(adminpassword, 0, sizeof(adminpassword));
  stream = fopen("adminpassword.txt", "r");
  if ( !stream )
  {
    printf("Can't read admin password!");
    exit(1);
  }
  readline(adminpassword, 32, stream);
  fclose(stream);
  for ( i = 0; i <= 7; ++i )
  {
    posts[i] = (Post *)malloc(0x184u);
    memset(posts[i], 0, sizeof(Post));
  }
  readpostsfromfile();
  menu();
}
