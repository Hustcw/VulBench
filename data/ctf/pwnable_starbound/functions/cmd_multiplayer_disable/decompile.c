int cmd_multiplayer_disable()
{
  if ( fd >= 0 )
  {
    close(fd);
    cleanup_sun();
  }
  return puts("[Info] Portal disabled");
}
