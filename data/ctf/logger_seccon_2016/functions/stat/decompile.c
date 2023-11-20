int __fastcall stat(char *filename, struct stat *stat_buf)
{
  return __xstat(1, filename, stat_buf);
}
