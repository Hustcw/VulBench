int __fastcall sub_1EF0(char *filename, struct stat *stat_buf)
{
  return __xstat(1, filename, stat_buf);
}
