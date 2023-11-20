char *sub_400C30()
{
  double v0;
  double v1;
  double v2;
  char *result;
  int v4;
  int i;
  int v6;
  int v7;
  char v8[12];
  int v9;
  __int16 v10;
  int v11;
  __int16 v12;
  int v13;
  __int16 v14;
  int v15;
  __int16 v16;
  _BYTE v17[11];
  char v18;
  int v19;
  _WORD v20[4];
  __int16 v21[3];
  _DWORD v22[9];
  struct timeval v23;
  struct timeval v24;
  char v25[28];

  v4 = 8;
  v6 = 0;
  i = 0;
  v7 = 0;
  v9 = 1466236928;
  v10 = 0;
  v12 = 0;
  v14 = 0;
  v16 = 0;
  v18 = 0;
  v20[0] = 0;
  v11 = 1634886912;
  v13 = 1735549284;
  v15 = 1718775661;
  strcpy(v17, "nomal");
  strcpy(&v17[6], "arch");
  v19 = 1650686464;
  strcpy((char *)&v20[1], "W3Are");
  qmemcpy(v21, "hakker", sizeof(v21));
  memcpy(v22, &unk_4013AC, sizeof(v22));
  gettimeofday(&v23, 0);
  while ( v4 > 0 )
  {
    v6 = sub_401020(v4);
    v7 = v22[v4];
    v22[v4] = v22[v6];
    v22[v6] = v7;
    --v4;
  }
  for ( i = 0; i < 9; ++i )
  {
    do
    {
      sub_400B38(v8, 9u);
      if ( strcmp(v8, (const char *)&v9 + 6 * v22[i]) )
        puts("no!!! guess it!!!!!!");
    }
    while ( strcmp(v8, (const char *)&v9 + 6 * v22[i]) );
  }
  gettimeofday(&v24, 0);
  v0 = sub_401070(v23.tv_sec, v23.tv_usec, v24.tv_sec, v24.tv_usec) * 0.000001;
  v1 = sub_401070(v23.tv_sec, v23.tv_usec, v24.tv_sec, v24.tv_usec);
  printf("\n\n%.0lf sec, %.0lf usec\n", v0, v1);
  v2 = sub_401070(v23.tv_sec, v23.tv_usec, v24.tv_sec, v24.tv_usec) * 0.000001;
  result = (char *)(v2 < 3.0);
  if ( v2 < 3.0 )
  {
    puts("... go!");
    return sub_400B38(v25, 0x400u);
  }
  return result;
}
