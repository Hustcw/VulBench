void add_entry()
{
  int v0;
  size_t v1;
  int v2;
  unsigned __int8 *name_;
  size_t size;
  char name[256];
  void *v6;
  ssize_t v7;

  memset(name, 0, sizeof(name));
  v7 = 0LL;
  size = 0LL;
  v6 = 0LL;
  printf("Name: ");
  v0 = fileno(stdin);
  v7 = read(v0, name, 0x100uLL);
  if ( v7 <= 0 )
    exit_();
  name[255] = 0;
  printf("Size: ");
  _isoc99_scanf("%lu", &size);
  fgetc(stdin);
  if ( size > 0x400 )
    exit_();
  v6 = malloc(size);
  if ( !v6 )
    exit_();
  printf("Value: ");
  v1 = size;
  v2 = fileno(stdin);
  v7 = read(v2, v6, v1);
  if ( v7 <= 0 )
    exit_();
  v6 = (void *)((size << 48) | (unsigned __int64)v6);
  name_ = (unsigned __int8 *)strdup(name);
  sub_CB6(name_, (__int64)v6);
}