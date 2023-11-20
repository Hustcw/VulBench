int DEBUG = 1;
char buff[64];
char s[32];
int DEBUG = 1;
char buff[64];
char s[32];

int admin()
{
  return system("sh");
}

void __cdecl read_server(uint16_t a1)
{
  struct sockaddr sock;
  ssize_t v2;
  int fd;

  memset(buff, 0, sizeof(buff));
  fd = socket(2, 1, 0);
  memset(&sock, 0, sizeof(sock));
  sock.sa_family = 2;
  *(_WORD *)sock.sa_data = htons(a1);
  inet_pton(2, s, &sock.sa_data[2]);
  while ( connect(fd, &sock, 0x10u) < 0 )
    sleep(1u);
  v2 = read(fd, buff, 0x40u);
  shutdown(fd, 0);
}

int __cdecl loop(int a1, int a2)
{
  char v3[260];

  memset(v3, 0, 256u);
  if ( DEBUG )
    printf("PORT: %d\n", a1);
  read_server(a1);
  strcpy(&v3[a2], buff);
  printf("GOT: %s\n", &v3[a2]);
  return a2 + 16;
}

int __cdecl __noreturn main(int argc, const char **argv, const char **envp)
{
  int v3;
  int v4;

  v4 = 0;
  printf("IP: ");
  fgets(s, 32, stdin);
  s[strlen(s) - 1] = 0;
  while ( 1 )
  {
    if ( time(0) == 0x58684680 )
    {
      admin();
    }
    else
    {
      v3 = rand();
      v4 = loop((unsigned __int16)(((unsigned int)(v3 >> 31) >> 16) + v3) - ((unsigned int)(v3 >> 31) >> 16), v4);
    }
  }
}
