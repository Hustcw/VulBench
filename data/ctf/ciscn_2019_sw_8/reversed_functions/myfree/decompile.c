void __cdecl myfree(char *ptr)
{
  size_t size;

  size = *((_QWORD *)ptr - 1);
  free(ptr);
  if ( size > 0x90 && (*(_QWORD *)&ptr[(size & 0xFFFFFFFFFFFFFFF8LL) - 8] & 1) != 0 )
  {
    puts("Down");
    exit(0);
  }
  puts("success");
}