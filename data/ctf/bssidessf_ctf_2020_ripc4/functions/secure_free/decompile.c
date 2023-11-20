void __cdecl secure_free(void *ptr)
{
  size_t sz;
  __int64 pg_size;

  pg_size = sysconf(30);
  mprotect((char *)ptr - pg_size, pg_size, 1);
  sz = *(_QWORD *)((char *)ptr - pg_size);
  memset(ptr, 0, sz - 2 * pg_size);
  munmap((char *)ptr - pg_size, sz);
}
