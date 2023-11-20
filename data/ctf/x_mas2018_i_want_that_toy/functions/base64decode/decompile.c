__int64 __fastcall base64decode(const char *a1, __int64 a2)
{
  int v3;
  int v4;
  int v5;
  int v6;
  int v7;
  int v8;
  int v9;
  int v10;
  int v11;
  int v12;
  int v13;
  int v14;
  int v15;
  int v16;
  int v17;
  int v18;
  int v19;
  int v20;
  int v21;
  int v22;
  unsigned __int64 v23;
  size_t v24;

  v24 = strlen(a1);
  if ( !decoding_table )
    build_decoding_table();
  if ( (v24 & 3) != 0 )
    return 0LL;
  v23 = 3 * (v24 >> 2);
  if ( a1[v24 - 1] == 61 )
    --v23;
  if ( a1[v24 - 2] == 61 )
    --v23;
  if ( !a2 )
    return 0LL;
  v14 = 0;
  v18 = 0;
  while ( v24 > v14 )
  {
    if ( a1[v14] == 61 )
    {
      v15 = v14 + 1;
      v3 = 0;
    }
    else
    {
      v4 = v14;
      v15 = v14 + 1;
      v3 = *((char *)decoding_table + a1[v4]);
    }
    v19 = v3;
    if ( a1[v15] == 61 )
    {
      v16 = v15 + 1;
      v5 = 0;
    }
    else
    {
      v6 = v15;
      v16 = v15 + 1;
      v5 = *((char *)decoding_table + a1[v6]);
    }
    v20 = v5;
    if ( a1[v16] == 61 )
    {
      v17 = v16 + 1;
      v7 = 0;
    }
    else
    {
      v8 = v16;
      v17 = v16 + 1;
      v7 = *((char *)decoding_table + a1[v8]);
    }
    v21 = v7;
    if ( a1[v17] == 61 )
    {
      v14 = v17 + 1;
      v9 = 0;
    }
    else
    {
      v10 = v17;
      v14 = v17 + 1;
      v9 = *((char *)decoding_table + a1[v10]);
    }
    v22 = (v21 << 6) + (v20 << 12) + (v19 << 18) + v9;
    if ( v23 > v18 )
    {
      v11 = v18++;
      *(_BYTE *)(v11 + a2) = BYTE2(v22);
    }
    if ( v23 > v18 )
    {
      v12 = v18++;
      *(_BYTE *)(v12 + a2) = BYTE1(v22);
    }
    if ( v23 > v18 )
    {
      v13 = v18++;
      *(_BYTE *)(v13 + a2) = v22;
    }
  }
  return a2;
}
