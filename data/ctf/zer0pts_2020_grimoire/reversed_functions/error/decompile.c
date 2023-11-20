void __fastcall error(const char *a1, const char *a2)
{
  size_t v2;
  size_t v3;
  size_t v4;
  size_t v5;
  char *s;
  char *v7;
  void *ptr;

  s = (char *)a1;
  if ( a1 && *a1 )
  {
    v7 = ": ";
  }
  else
  {
    v7 = (char *)&unk_15DE;
    s = (char *)&unk_15DE;
  }
  v2 = strlen(s);
  v3 = strlen(v7) + v2;
  v4 = strlen(a2);
  ptr = malloc(v3 + v4 + 2);
  v5 = malloc_usable_size(ptr);
  snprintf((char *)ptr, v5, "%s%s%s\n", s, v7, a2);
  fprintf(stderr, (const char *)ptr);
  free(ptr);
}