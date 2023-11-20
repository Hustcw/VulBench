unsigned __int64 __fastcall print_asciiart(const char *a1)
{
  FILE *stream;
  char s[72];
  unsigned __int64 v4;

  v4 = __readfsqword(0x28u);
  stream = fopen(a1, "r");
  if ( stream )
  {
    while ( fgets(s, 64, stream) )
      printf("%s", s);
    fclose(stream);
  }
  return __readfsqword(0x28u) ^ v4;
}
