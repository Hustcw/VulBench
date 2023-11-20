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