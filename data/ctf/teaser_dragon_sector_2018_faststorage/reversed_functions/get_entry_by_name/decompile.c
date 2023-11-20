__int64 __fastcall get_entry_by_name(char **a1, unsigned __int64 *a2)
{
  int v2;
  char buf[256];
  char *v5;
  ssize_t v6;

  memset(buf, 0, sizeof(buf));
  v6 = 0LL;
  v5 = 0LL;
  printf("Name: ");
  v2 = fileno(stdin);
  v6 = read(v2, buf, 0x100uLL);
  if ( v6 <= 0 )
    exit_();
  buf[255] = 0;
  v5 = get_entry(buf);
  if ( !v5 )
    return 0LL;
  *a2 = (unsigned __int64)v5 >> 48;
  *a1 = (char *)((unsigned __int64)v5 & 0xFFFFFFFFFFFFLL);
  return 1LL;
}