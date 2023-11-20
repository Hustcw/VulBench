int __fastcall sub_4008FD(void *a1, const char *a2, __off_t a3, size_t a4)
{
  int fd;

  fd = open(a2, 0);
  if ( fd == -1 )
    return puts("You can't read this file...");
  lseek(fd, a3, 0);
  if ( read(fd, a1, a4) > 0 )
    puts("Load file complete!");
  return close(fd);
}
