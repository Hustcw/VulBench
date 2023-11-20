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