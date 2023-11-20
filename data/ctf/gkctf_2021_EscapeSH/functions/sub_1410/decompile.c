int sub_1410()
{
  int result;

  result = dl_iterate_phdr((int (*)(struct dl_phdr_info *, size_t, void *))callback, "EscapeSh");
  if ( result )
  {
    fwrite("dl_iterate_phdr() failed.\n", 1uLL, 0x1AuLL, stderr);
    exit(1);
  }
  return result;
}
