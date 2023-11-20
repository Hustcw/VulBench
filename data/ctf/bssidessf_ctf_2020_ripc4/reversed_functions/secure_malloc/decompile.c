void *__cdecl secure_malloc(size_t sz)
{
  int *v1;
  char *v2;
  size_t sza;
  _QWORD *ptr;
  __int64 pg_size;

  pg_size = sysconf(30);
  sza = 2 * pg_size + ((sz + pg_size - 1) & -pg_size);
  ptr = mmap(0LL, sza, 7, 8226, -1, 0LL);
  if ( ptr == (_QWORD *)-1LL )
  {
    puts("Unable to allocate memory!\n");
    v1 = __errno_location();
    v2 = strerror(*v1);
    printf("Error: %s\n", v2);
    _exit(1);
  }
  *ptr = sza;
  mprotect(ptr, pg_size, 0);
  mprotect((char *)ptr + sza - pg_size, pg_size, 0);
  return (char *)ptr + pg_size;
}