unsigned __int64 __fastcall SPFA(int a1, int a2)
{
  int v3;
  int v4;
  int i;
  int v6;
  int v7;
  int s[1008];
  int v9[1010];
  unsigned __int64 v10;

  v10 = __readfsqword(0x28u);
  memset(s, 127, 0xFBCuLL);
  memset(v9, 0, 0xFBCuLL);
  v3 = 0;
  v4 = 1;
  s[a1] = 0;
  v9[a1] = 1;
  qu[0] = a1;
  while ( v3 != v4 )
  {
    v6 = qu[v3++];
    for ( i = head[v6]; i; i = next[i] )
    {
      v7 = to[i];
      if ( s[v7] >= s[v6] + len[i] )
      {
        s[v7] = len[i] + s[v6];
        if ( !v9[v7] )
        {
          v9[v7] = 1;
          qu[v4++] = v7;
          if ( v4 > 1000 )
          {
            puts("queue overflow error!");
            return __readfsqword(0x28u) ^ v10;
          }
        }
      }
    }
    v9[v6] = 0;
  }
  printf("%d\n", (unsigned int)s[a2]);
  return __readfsqword(0x28u) ^ v10;
}
