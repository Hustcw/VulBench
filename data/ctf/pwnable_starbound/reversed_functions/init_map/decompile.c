void init_map()
{
  int v0;
  signed int v1;
  int i;
  char v3;
  int j;
  int k;
  int v6;
  int m;
  int v8;
  signed int v9;
  int v10;
  int v11;
  int v12;
  int n;

  v0 = rand();
  v1 = (v0 % 400 + 100) & 0xFFFFFFFE;
  __memset_chk(&map[2], 0, v1, 512);
  for ( i = 0; v1 - 4 > i; i += 4 )
  {
    v3 = rand() & 7;
    for ( j = 0; j <= 7; ++j )
      map[i + 2 + j] += v3;
  }
  dword_8058150 = (v1 >> 1) + rand() % 20;
  for ( k = 1; v1 - 1 > k; ++k )
  {
    v6 = map[k + 3] + map[k + 1] + 2 * map[k + 2];
    map[k + 2] = (v6 + (rand() & 1)) >> 2;
  }
  map[2] = (map[v1 + 1] + 2 * map[2] + map[3]) >> 2;
  map[v1 + 1] = (map[v1] + 2 * map[v1 + 1] + map[2]) >> 2;
  for ( m = 0; m <= 30; ++m )
  {
    v8 = (dword_8058150 + m) % v1;
    v9 = 16 - abs32(m - 15) + rand() % 2;
    if ( v9 >= 14 )
      v9 = 13;
    if ( map[v8 + 2] < v9 )
      map[v8 + 2] = v9;
    if ( (unsigned int)(m - 13) <= 4 )
    {
      v10 = (unsigned __int8)map[v8 + 2];
      v11 = rand();
      v12 = v10 - (((v11 < 0) + (_BYTE)v11) & 1) + ((unsigned int)v11 >> 31) - 2;
      if ( (v12 & 0x80u) != 0 )
        LOBYTE(v12) = 0;
      map[v8 + 2] = v12;
    }
  }
  dword_8058150 += 15;
  for ( n = 0; v1 >> 1 > n; ++n )
    byte_8057F98[n] = map[2 * n + 2] + 16 * map[2 * n + 3];
  dword_8057F84 = (v0 % 400 + 100) & 0xFFFFFFFE;
}