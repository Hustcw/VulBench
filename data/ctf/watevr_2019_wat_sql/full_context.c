int dword_6020FC;
int dword_602100;
char byte_602120[200];
char nptr[16];
pthread_t newthread;
char haystack[32];
char name[128];
int dword_6022A0;
char *s2;
pthread_t th;
void __fastcall start_routine(void *a1)
{
  char *i;
  int v2;
  FILE *stream;
  char s[200];
  unsigned __int64 v5;

  v5 = __readfsqword(0x28u);
  v2 = 0;
  stream = fopen(name, "r");
  for ( i = fgets(s, 200, stream); i && v2 != dword_6022A0; i = fgets(s, 200, stream) )
    ++v2;
  strtok(s, "\n");
  printf("Data: %s\n", s);
  fclose(stream);
  dword_6020FC = 0;
}
void __fastcall sub_400CE0(void *a1)
{
  int v1;
  FILE *v2;
  FILE *stream;
  char s[104];
  unsigned __int64 v5;

  v5 = __readfsqword(0x28u);
  dword_6020FC = 0;
  v1 = 0;
  fflush(stdin);
  if ( access("/home/ctf/replace.tmp", 0) != -1 )
    remove("/home/ctf/replace.tmp");
  v2 = fopen(name, "r");
  stream = fopen("replace.tmp", "w");
  if ( v2 && stream )
  {
    while ( fgets(s, 100, v2) )
    {
      if ( v1 == dword_6022A0 )
        fputs(byte_602120, stream);
      else
        fputs(s, stream);
      ++v1;
    }
    fclose(v2);
    fclose(stream);
    remove(name);
    rename("/home/ctf/replace.tmp", name);
  }
  else
  {
    puts("Unable to open file.");
  }
}
void sub_400E30()
{
  printf("%s", "database to read from: ");
  fflush(stdout);
  fgets(name, 100, stdin);
  strtok(name, "\n");
  if ( (strstr(name, "flag") || strchr(name, 42) || strchr(name, 63)) && !dword_6020FC )
  {
    puts("You are not allowed access to that database!");
    dword_6020FC = 0;
  }
  else
  {
    dword_6020FC = 1;
    if ( access(name, 0) == -1 )
    {
      puts("Tried to open non-existing database");
    }
    else
    {
      printf("%s", "database to read: ");
      fflush(stdout);
      fgets(nptr, 7, stdin);
      dword_6022A0 = atoi(nptr) + 1;
      pthread_create(&th, 0LL, (void *(*)(void *))start_routine, 0LL);
      pthread_join(th, 0LL);
      dword_6020FC = 0;
    }
  }
}
void sub_400FB7()
{
  printf("%s", "database to write to: ");
  fflush(stdout);
  fgets(name, 100, stdin);
  strtok(name, "\n");
  if ( (strstr(name, "flag") || strchr(name, 42) || strchr(name, 63)) && !dword_6020FC )
  {
    puts("You are not allowed access to that database!");
    dword_6020FC = 0;
  }
  else
  {
    dword_6020FC = 1;
    if ( access(name, 0) == -1 )
    {
      puts("Tried to open non-existing database");
    }
    else
    {
      printf("%s", "Database to write to: ");
      fflush(stdout);
      fgets(nptr, 8, stdin);
      printf("%s", "Data to write: ");
      fflush(stdout);
      fgets(byte_602120, 200, stdin);
      dword_6022A0 = atoi(nptr);
      pthread_create(&newthread, 0LL, (void *(*)(void *))sub_400CE0, 0LL);
    }
  }
}
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
        return;
      }
      sub_400E30();
    }
    if ( strstr(haystack, "write") )
    {
      sub_400FB7();
      if ( ++dword_602100 > 2 )
      {
        printf("You have exhausted the request limit for your wat-sql demo!");
        return;
      }
    }
    else
    {
      puts("Unrecognised command!");
    }
  }
}
int sub_40128B()
{
  printf("%s", "Demo activation code: ");
  fflush(stdout);
  fgets(s2, 36, stdin);
  if ( !strcmp("watevr-sql2019-demo-code-admin", s2) && *((_DWORD *)s2+8) == 0x796573 )
    return puts("Demo access granted!");
  else
    return puts("Demo access not granted!");
}
void __fastcall main(int a1, char **a2, char **a3)
{
  s2 = (char *)malloc(32uLL);
  sub_40128B();
  if ( *((_DWORD *)s2+8) != 0x796573 )
    exit(0);
  sub_40115F();
}