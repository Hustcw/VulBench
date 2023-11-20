ssize_t __cdecl read_server(uint16_t a1)
{
  struct sockaddr s;
  ssize_t v3;
  int fd;

  memset(buff, 0, sizeof(buff));
  fd = socket(2, 1, 0);
  memset(&s, 0, sizeof(s));
  s.sa_family = 2;
  *(_WORD *)s.sa_data = htons(a1);
  inet_pton(2, &::s, &s.sa_data[2]);
  while ( connect(fd, &s, 0x10u) < 0 )
    sleep(1u);
  v3 = read(fd, buff, 0x40u);
  shutdown(fd, 0);
  return v3;
}
