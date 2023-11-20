int cmd_multiplayer_enable()
{
  __pid_t v0;
  socklen_t len;
  struct sockaddr addr;

  if ( fd != -1 )
    close(fd);
  addr.sa_family = 1;
  fd = socket(1, 2, 0);
  if ( fd >= 0 )
  {
    mkdir("/home/starbound/.multiplayer", 0x1C0u);
    v0 = getpid();
    __sprintf_chk(addr.sa_data, 1, 108, "/home/starbound/.multiplayer/%d", v0);
    unlink(addr.sa_data);
    if ( bind(fd, &addr, 0x6Eu) >= 0 )
    {
      len = 110;
      if ( getsockname(fd, &addr, &len) >= 0 )
        return __printf_chk(1, "[Info] Portal %d enabled\n", v0);
    }
  }
  puts("[Error] Fail to enable");
  return close(fd);
}
