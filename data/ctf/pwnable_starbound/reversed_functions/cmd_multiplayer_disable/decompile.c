void cmd_multiplayer_disable()
{
  if ( fd >= 0 )
  {
    close(fd);
    cleanup_sun();
  }
  puts("[Info] Portal disabled");
}