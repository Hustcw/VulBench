void sub_400C30()
{
  double v0;
  double v1;
  int v2;
  int i;
  int v4;
  int v5;
  char v6[12];
  int v7;
  __int16 v8;
  int v9;
  __int16 v10;
  int v11;
  __int16 v12;
  int v13;
  __int16 v14;
  _BYTE v15[11];
  char v16;
  int v17;
  _WORD v18[4];
  __int16 v19[3];
  int v20[9];
  struct timeval v21;
  struct timeval v22;
  char v23[28];

  v2 = 8;
  v4 = 0;
  i = 0;
  v5 = 0;
  v7 = 0x57650000;
  v8 = 0;
  v10 = 0;
  v12 = 0;
  v14 = 0;
  v16 = 0;
  v18[0] = 0;
  v9 = 0x61726500;
  v11 = 0x67726164;
  v13 = 0x66726F6D;
  strcpy(v15, "nomal");
  strcpy(&v15[6], "arch");
  v17 = 0x62637A00;
  strcpy((char *)&v18[1], "W3Are");
  qmemcpy(v19, "hakker", sizeof(v19));
  memcpy(v20, &unk_4013AC, sizeof(v20));
  gettimeofday(&v21, 0);
  while ( v2 > 0 )
  {
    v4 = sub_401020(v2);
    v5 = v20[v2];
    v20[v2] = v20[v4];
    v20[v4] = v5;
    --v2;
  }
  for ( i = 0; i < 9; ++i )
  {
    do
    {
      sub_400B38(v6, 9);
      if ( strcmp(v6, (const char *)&v7 + 6 * v20[i]) )
        puts("no!!! guess it!!!!!!");
    }
    while ( strcmp(v6, (const char *)&v7 + 6 * v20[i]) );
  }
  gettimeofday(&v22, 0);
  v0 = sub_401070(v21.tv_sec, v21.tv_usec, v22.tv_sec, v22.tv_usec) * 0.000001;
  v1 = sub_401070(v21.tv_sec, v21.tv_usec, v22.tv_sec, v22.tv_usec);
  printf("\n\n%.0lf sec, %.0lf usec\n", v0, v1);
  if ( sub_401070(v21.tv_sec, v21.tv_usec, v22.tv_sec, v22.tv_usec) * 0.000001 < 3.0 )
  {
    puts("... go!");
    sub_400B38(v23, 1024);
  }
}