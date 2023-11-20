struct Mail
{
  Mail *root;
  char title[64];
  int content_len;
  char content[];
};

Mail helloworld;
Mail *root;
struct Mail
{
  Mail *root;
  char title[64];
  int content_len;
  char content[];
};

Mail helloworld;
Mail *root;

int readint()
{
  char s[32];
  unsigned int v2;

  v2 = __readgsdword(0x14u);
  fgets(s, 32, stdin);
  return strtoll(s, 0, 10);
}

_DWORD *__cdecl new_mail(int a1)
{
  _DWORD *result;

  result = malloc(a1 + 72);
  *result = 0;
  result[17] = a1;
  return result;
}

void write_mail()
{
  int v0;
  Mail *v1;

  printf("Content Length: ");
  v0 = readint();
  v1 = (Mail *)new_mail(v0);
  printf("Title: ");
  gets(v1->title);
  printf("Content: ");
  gets(v1->content);
  v1->root = root;
  root = v1;
}

void dump_mail()
{
  Mail *v0;
  int v1;

  v0 = root;
  v1 = 1;
  while ( v0 )
  {
    printf("-- Mail %d:\n", v1);
    printf("Title: %s\n", v0->title);
    printf("Content: ");
    fwrite(v0->content, 1u, v0->content_len, stdout);
    printf("\n-- End mail %d\n", v1++);
    v0 = v0->root;
  }
  puts("-- No more mail!");
}

void service()
{
  int v0;

  root = &helloworld;
  memcpy(helloworld.content, "Hello, World", 0xCu);
  while ( 1 )
  {
    while ( 1 )
    {
      puts("0. Exit");
      puts("1. Write mail");
      puts("2. Dump mails");
      printf("Action: ");
      v0 = readint();
      if ( v0 != 1 )
        break;
      write_mail();
    }
    if ( !v0 )
      break;
    if ( v0 == 2 )
      dump_mail();
    else
      puts("Invalid choice");
  }
  puts("Bye");
}

int __cdecl main(int argc, const char **argv, const char **envp)
{
  setvbuf(stdin, 0, 2, 0);
  setvbuf(stdout, 0, 2, 0);
  alarm(0x258u);
  service();
  return 0;
}
