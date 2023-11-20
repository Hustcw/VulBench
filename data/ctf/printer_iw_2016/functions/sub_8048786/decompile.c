void __cdecl sub_8048786(char *cp, uint16_t a2)
{
  char buf[8192];
  struct sockaddr addr;
  int fd;

  fd = socket(2, 1, 0);
  if ( fd == -1 )
  {
    puts("No socket :(");
  }
  else
  {
    *(_DWORD *)&addr.sa_data[2] = inet_addr(cp);
    addr.sa_family = 2;
    *(_WORD *)addr.sa_data = htons(a2);
    if ( connect(fd, &addr, 0x10u) >= 0 )
    {
      if ( recv(fd, buf, 0x2000u, 0) >= 0 )
      {
        printf(buf);
        close(fd);
      }
      else
      {
        puts("No data :(");
      }
    }
    else
    {
      perror("No communication :(\n");
    }
  }
}
