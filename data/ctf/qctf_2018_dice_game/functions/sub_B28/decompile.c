int __fastcall sub_B28(const char *a1)
{
  char s[104];
  FILE *stream;

  printf("Congrats %s\n", a1);
  stream = fopen("flag", "r");
  fgets(s, 100, stream);
  puts(s);
  return fflush(stdout);
}
