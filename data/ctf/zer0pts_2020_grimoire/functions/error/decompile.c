unsigned __int64 __fastcall error(const char *a1, const char *a2)
{
  size_t v2;
  size_t v3;
  size_t v4;
  size_t v5;
  char *s;
  char *v8;
  void *ptr;
  unsigned __int64 v10;

  s = (char *)a1;
  v10 = __readfsqword(0x28u);
  if ( a1 && *a1 )
  {
    v8 = ": ";
    v2 = strlen(a1);
  }
  else
  {
    v8 = (char *)&unk_15DE;
    s = (char *)&unk_15DE;
    v2 = strlen((const char *)&unk_15DE);
  }
  v3 = strlen(v8) + v2;
  v4 = strlen(a2);
  ptr = malloc(v3 + v4 + 2);
  v5 = malloc_usable_size(ptr);
  snprintf((char *)ptr, v5, "%s%s%s\n", s, v8, a2);
  fprintf(stderr, (const char *)ptr);
  free(ptr);
  return __readfsqword(0x28u) ^ v10;
}
