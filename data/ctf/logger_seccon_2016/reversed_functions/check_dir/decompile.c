_BOOL8 check_dir()
{
  struct stat v1;

  if ( stat("/tmp/logger", &v1) )
  {
    puts("Stat error. /tmp/logger exists?");
    exit(1);
  }
  return (v1.st_mode & 0xF000) == 0x4000;
}