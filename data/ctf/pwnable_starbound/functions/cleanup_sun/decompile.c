int cleanup_sun()
{
  __pid_t v0;
  char name[116];

  v0 = getpid();
  __sprintf_chk(name, 1, 104, "/home/starbound/.multiplayer/%d", v0);
  return unlink(name);
}
