int __fastcall start_routine(void *a1)
{
  char *i;
  int result;
  int v3;
  FILE *stream;
  char s[200];
  unsigned __int64 v6;

  v6 = __readfsqword(0x28u);
  v3 = 0;
  stream = fopen(name, "r");
  for ( i = fgets(s, 200, stream); i && v3 != dword_6022A0; i = fgets(s, 200, stream) )
    ++v3;
  strtok(s, "\n");
  printf("Data: %s\n", s);
  result = fclose(stream);
  dword_6020FC = 0;
  return result;
}
