

int __cdecl main(int argc, const char **argv, const char **envp)
{
  void *v3; 
  _BYTE v5[8]; 
  int n; 
  int v7; 

  printf("Hello, I'm Nao.\nGive me your cheering messages :)\n\nMessage Length >> ");
  n = getint();
  v3 = alloca(16 * ((n + 30) / 0x10u));
  v7 = (int)v5;
  return message((int)v5, n);
}

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

size_t __cdecl getnline(char *s, int n)
{
  char *v3; 

  fgets(s, n, stdin);
  v3 = strchr(s, 10);
  if ( v3 )
    *v3 = 0;
  return strlen(s);
}

int getint()
{
  char nptr[64]; 
  unsigned int v2; 

  v2 = __readgsdword(0x14u);
  getnline(nptr, 64);
  return atoi(nptr);
}
