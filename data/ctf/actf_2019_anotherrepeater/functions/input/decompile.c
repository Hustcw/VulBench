unsigned __int16 *input()
{
  unsigned __int16 v1;
  _BYTE buf[1025];
  unsigned __int16 v3;

  *(_DWORD *)buf = 4144959;
  *(_DWORD *)&buf[4] = 0;
  *(_DWORD *)&buf[1021] = 0;
  memset(&buf[7], 0, 4 * (((&buf[4] - &buf[7] + 1021) & 0xFFFFFFFC) >> 2));
  __isoc99_scanf("%hd", &v1);
  if ( (__int16)v1 > 1024 )
  {
    puts("No way, you can't repeat so many chars!");
    exit(0);
  }
  v3 = v1;
  printf("%x %u\n", buf, v1);
  read(0, buf, v3);
  qmemcpy(str, buf, 0x400u);
  str[1024] = buf[1024];
  return &v3;
}
