unsigned int sub_8048B87()
{
  struct sigaction v1;
  struct sigaction v2;
  unsigned int v3;

  v3 = __readgsdword(0x14u);
  v1.sa_handler = (__sighandler_t)sub_804880D;
  sigemptyset(&v1.sa_mask);
  v1.sa_flags = 0x20000000;
  if ( sigaction(14, &v1, &v2) < 0 )
  {
    perror("[!] Sigaction Error!");
    exit(0);
  }
  alarm(5u);
  sub_8048851();
  sub_8048A71();
  sub_8048881();
  return __readgsdword(0x14u) ^ v3;
}
