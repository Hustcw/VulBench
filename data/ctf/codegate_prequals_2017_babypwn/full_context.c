int fd;
int dword_804B1BC;

int fd;
int dword_804B1BC;

unsigned int sub_804880D()
{
  sub_80488B1("\nTime Out!\n");
  close(fd);
  return __readgsdword(0x14u) ^ v1;
}

ssize_t __cdecl sub_80488B1(const char *a1)
{
  size_t v1;

  v1 = strlen(a1);
  return send(fd, a1, v1, 0);
}

ssize_t __cdecl sub_8048907(void *a1, size_t a2)
{
  return recv(fd, a1, a2, 0);
}

int sub_804895A()
{
  ssize_t v1;
  char nptr[120];

  sub_80488B1("Select menu > ");
  v1 = sub_8048907(nptr, 0x78u);
  nptr[v1 - 1] = 0;
  return atoi(nptr);
}

const char *__cdecl sub_80489C8(const char *a1)
{
  const char *v2;
  const char *i;

  if ( !a1 || !*a1 )
    return a1;
  v2 = a1;
  for ( i = &a1[strlen(a1) - 1]; i > v2; --i )
  {
    *v2 ^= *i;
    *i ^= *v2;
    *v2++ ^= *i;
  }
  return a1;
}

void sub_8048A71()
{
  int v0;
  char v1[40];

  memset(v1, 0, sizeof(v1));
  while ( 1 )
  {
    while ( 1 )
    {
      while ( 1 )
      {
        sub_80488B1("\n===============================\n");
        sub_80488B1("1. Echo\n");
        sub_80488B1("2. Reverse Echo\n");
        sub_80488B1("3. Exit\n");
        sub_80488B1("===============================\n");
        v0 = sub_804895A();
        if ( v0 != 1 )
          break;
        sub_80488B1("Input Your Message : ");
        sub_8048907(v1, 0x64u);
        sub_80488B1(v1);
      }
      if ( v0 != 2 )
        break;
      sub_80488B1("Input Your Message : ");
      sub_8048907(v1, 0x64u);
      sub_80489C8(v1);
      sub_80488B1(v1);
    }
    if ( v0 == 3 )
      break;
    sub_80488B1("\n[!] Wrong Input\n");
  }
}

void sub_8048B87()
{
  struct sigaction v0;
  struct sigaction v1;

  sub_8048851();
  sub_8048A71();
}

void sub_8048C3B()
{
  system("echo 'not easy to see.'");
}

unsigned int __cdecl main(int a1, char **a2)
{
  socklen_t addr_len;
  int optval;
  int v5;
  struct sockaddr addr;
  struct sockaddr v7;
  unsigned int v8;

  v8 = __readgsdword(0x14u);
  if ( a1 == 2 )
    v5 = atoi(a2[1]);
  else
    v5 = 8181;
  dword_804B1BC = socket(2, 1, 0);
  if ( dword_804B1BC == -1 )
  {
    perror("[!] socket Error!");
    exit(1);
  }
  addr.sa_family = 2;
  *(_WORD *)addr.sa_data = htons(v5);
  *(_DWORD *)&addr.sa_data[2] = 0;
  bzero(&addr.sa_data[6], 8u);
  optval = 1;
  setsockopt(dword_804B1BC, 1, 2, &optval, 4u);
  if ( bind(dword_804B1BC, &addr, 0x10u) == -1 )
  {
    perror("[!] bind Error!");
    exit(1);
  }
  if ( listen(dword_804B1BC, 1024) == -1 )
  {
    perror("[!] listen Error!");
    exit(1);
  }
  while ( 1 )
  {
    while ( 1 )
    {
      addr_len = 16;
      fd = accept(dword_804B1BC, &v7, &addr_len);
      if ( fd != -1 )
        break;
      perror("[!] accept Error!");
    }
    if ( !fork() )
      break;
    close(fd);
    while ( waitpid(-1, 0, 1) > 0 )
      ;
  }
  sub_8048B87();
  close(dword_804B1BC);
  close(fd);
  return 0;
}
