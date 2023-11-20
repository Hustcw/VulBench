int __cdecl loop(int a1, int a2)
{
  char v3[260];

  memset(v3, 0, 0x100u);
  if ( DEBUG )
    printf("PORT: %d\n", a1);
  read_server(a1);
  strcpy(&v3[a2], buff);
  printf("GOT: %s\n", &v3[a2]);
  return a2 + 16;
}
