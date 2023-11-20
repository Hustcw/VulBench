int __fastcall sub_B28(const char *a1)
{
  char s[104]; // [rsp+10h] [rbp-70h] BYREF
  FILE *stream; // [rsp+78h] [rbp-8h]

  printf("Congrats %s\n", a1);
  stream = fopen("flag", "r");
  fgets(s, 100, stream);
  puts(s);
  return fflush(stdout);
}