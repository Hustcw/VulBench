int __fastcall puts_flush(const char *a1)
{
  puts(a1);
  return fflush(stdout);
}