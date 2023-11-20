void __fastcall read_str_from_file(void *a1, const char *a2, __off_t a3, size_t a4)
{
  int fd;

  fd = open(a2, 0);
  if ( fd == -1 )
  {
    puts("You can't read this file...");
  }
  else
  {
    lseek(fd, a3, 0);
    if ( read(fd, a1, a4) > 0 )
      puts("Load file complete!");
    close(fd);
  }
}