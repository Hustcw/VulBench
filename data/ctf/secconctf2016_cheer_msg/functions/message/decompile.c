unsigned int __cdecl message(char *a1, int n)
{
  char v3[64];
  unsigned int v4;

  v4 = __readgsdword(0x14u);
  printf("Message >> ");
  getnline(a1, n);
  printf("\nOops! I forgot to ask your name...\nCan you tell me your name?\n\nName >> ");
  getnline(v3, 64);
  printf("\nThank you %s!\nMessage : %s\n", v3, a1);
  return __readgsdword(0x14u) ^ v4;
}
