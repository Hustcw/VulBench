unsigned __int64 __fastcall startServer(const char *a1)
{
  int optval;
  struct addrinfo *pai;
  struct addrinfo *i;
  struct addrinfo s;
  unsigned __int64 v6;

  v6 = __readfsqword(0x28u);
  memset(&s, 0, sizeof(s));
  s.ai_family = 2;
  s.ai_socktype = 1;
  s.ai_flags = 1;
  if ( getaddrinfo(0LL, a1, &s, &pai) )
  {
    perror("getaddrinfo() error");
    exit(1);
  }
  for ( i = pai; i; i = i->ai_next )
  {
    optval = 1;
    listenfd = socket(i->ai_family, i->ai_socktype, 0);
    setsockopt(listenfd, 1, 2, &optval, 4u);
    if ( listenfd != -1 && !bind(listenfd, i->ai_addr, i->ai_addrlen) )
      break;
  }
  if ( !i )
  {
    perror("socket() or bind()");
    exit(1);
  }
  freeaddrinfo(pai);
  if ( listen(listenfd, 1000000) )
  {
    perror("listen() error");
    exit(1);
  }
  return __readfsqword(0x28u) ^ v6;
}
