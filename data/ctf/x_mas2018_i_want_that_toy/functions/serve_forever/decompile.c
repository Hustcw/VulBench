void __fastcall __noreturn serve_forever(__int64 a1)
{
  socklen_t addr_len;
  int fd;
  struct sockaddr addr;
  unsigned __int64 v4;

  v4 = __readfsqword(0x28u);
  startServer(a1);
  signal(17, (__sighandler_t)((char *)&dword_0 + 1));
  while ( 1 )
  {
    while ( 1 )
    {
      addr_len = 16;
      fd = accept(listenfd, &addr, &addr_len);
      if ( fd >= 0 )
        break;
      perror("accept() error");
    }
    if ( !fork() )
    {
      respond((unsigned int)fd);
      exit(0);
    }
    close(fd);
  }
}
