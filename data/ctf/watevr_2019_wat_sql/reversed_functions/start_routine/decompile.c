void __fastcall start_routine(void *a1)
{
  char *i;
  int v2;
  FILE *stream;
  char s[200];
  unsigned __int64 v5;

  v5 = __readfsqword(0x28u);
  v2 = 0;
  stream = fopen(name, "r");
  for ( i = fgets(s, 200, stream); i && v2 != dword_6022A0; i = fgets(s, 200, stream) )
    ++v2;
  strtok(s, "\n");
  printf("Data: %s\n", s);
  fclose(stream);
  dword_6020FC = 0;
}