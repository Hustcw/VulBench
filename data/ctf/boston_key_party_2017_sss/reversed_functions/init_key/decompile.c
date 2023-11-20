void init_key()
{
  FILE *stream;
  __int64 size;
  char *ptr;

  stream = fopen("flag", "rb");
  fseek(stream, 0LL, 2);
  size = ftell(stream);
  fseek(stream, 0LL, 0);
  ptr = (char *)calloc(1uLL, size + 1);
  if ( !ptr )
    exit(1);
  fread(ptr, size, 1uLL, stream);
  fclose(stream);
  ptr[size] = 0;
  key = strdup(ptr);
  free(ptr);
}