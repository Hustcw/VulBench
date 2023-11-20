char str[1056];
char str[1056];
int main()
{
  __int16 v1; // [esp+Ah] [ebp-41Eh] BYREF
  _BYTE buf[1025]; // [esp+Dh] [ebp-41Bh] BYREF
  unsigned __int16 v3; // [esp+40Eh] [ebp-1Ah] BYREF

  *(_DWORD *)buf = 0x3F3F3F;
  *(_DWORD *)&buf[4] = 0;
  *(_DWORD *)&buf[1021] = 0;
  memset(&buf[7], 0, 4 * (((&buf[4] - &buf[7] + 1021) & 0xFFFFFFFC) >> 2));
  __isoc99_scanf("%hd", &v1);
  if ( v1 > 1024 )
  {
    puts("No way, you can't repeat so many chars!");
    exit(0);
  }
  v3 = v1;
  printf("%x %u\n", buf, (unsigned __int16)v1);
  read(0, buf, v3);
  qmemcpy(str, buf, 1024u);
  str[1024] = buf[1024];
  return 0;
}
