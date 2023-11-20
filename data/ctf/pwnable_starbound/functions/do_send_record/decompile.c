int __cdecl do_send_record(void *buf, size_t n)
{
  int v2;
  struct sockaddr addr;

  v2 = socket(2, 1, 0);
  *(_DWORD *)&addr.sa_data[2] = inet_addr(cp);
  addr.sa_family = 2;
  *(_WORD *)addr.sa_data = 27002;
  if ( connect(v2, &addr, 0x10u) >= 0 )
  {
    write(v2, buf, n);
    puts("[Info] Record sended.");
  }
  else
  {
    puts("[Error] Fail to send your record. Make sure that you are listening 31337.");
  }
  return close(v2);
}
