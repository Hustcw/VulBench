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