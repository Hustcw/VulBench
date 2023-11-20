void __cdecl sub_8048786(char *cp, uint16_t a2)
{
  char buf[8192]; // [esp+Ch] [ebp-201Ch] BYREF
  struct sockaddr addr; // [esp+200Ch] [ebp-1Ch] BYREF
  int fd; // [esp+201Ch] [ebp-Ch]

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
      if ( recv(fd, buf, 8192u, 0) >= 0 )
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