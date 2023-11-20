__int64 __fastcall sub_E3A(unsigned __int64 *a1, unsigned __int64 *a2)
{
  int v2;
  char buf[256];
  __int64 *v5;
  ssize_t v6;

  memset(buf, 0, sizeof(buf));
  v6 = 0LL;
  v5 = 0LL;
  printf("Name: ");
  v2 = fileno(stdin);
  v6 = read(v2, buf, 0x100uLL);
  if ( v6 <= 0 )
    sub_A70();
  buf[255] = 0;
  v5 = sub_D54((unsigned __int8 *)buf);
  if ( !v5 )
    return 0LL;
  *a2 = (unsigned __int64)v5 >> 48;
  *a1 = (unsigned __int64)v5 & 0xFFFFFFFFFFFFLL;
  return 1LL;
}
