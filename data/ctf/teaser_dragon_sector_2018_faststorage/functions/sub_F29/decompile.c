_DWORD *sub_F29()
{
  int v0;
  size_t v1;
  int v2;
  unsigned __int8 *v3;
  size_t size;
  char buf[256];
  void *v7;
  ssize_t v8;

  memset(buf, 0, sizeof(buf));
  v8 = 0LL;
  size = 0LL;
  v7 = 0LL;
  printf("Name: ");
  v0 = fileno(stdin);
  v8 = read(v0, buf, 0x100uLL);
  if ( v8 <= 0 )
    sub_A70();
  buf[255] = 0;
  printf("Size: ");
  _isoc99_scanf("%lu", &size);
  fgetc(stdin);
  if ( size > 0x400 )
    sub_A70();
  v7 = malloc(size);
  if ( !v7 )
    sub_A70();
  printf("Value: ");
  v1 = size;
  v2 = fileno(stdin);
  v8 = read(v2, v7, v1);
  if ( v8 <= 0 )
    sub_A70();
  v7 = (void *)((size << 48) | (unsigned __int64)v7);
  v3 = (unsigned __int8 *)strdup(buf);
  return sub_CB6(v3, (__int64)v7);
}
