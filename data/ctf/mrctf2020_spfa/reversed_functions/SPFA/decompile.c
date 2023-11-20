void __fastcall SPFA(int a1, int a2)
{
  int v2; // [rsp+18h] [rbp-1FA8h]
  int v3; // [rsp+1Ch] [rbp-1FA4h]
  int i; // [rsp+20h] [rbp-1FA0h]
  int v5; // [rsp+28h] [rbp-1F98h]
  int v6; // [rsp+2Ch] [rbp-1F94h]
  int s[1008]; // [rsp+30h] [rbp-1F90h] BYREF
  int v8[1010]; // [rsp+FF0h] [rbp-FD0h] BYREF
  unsigned __int64 v9; // [rsp+1FB8h] [rbp-8h]

  v9 = __readfsqword(0x28u);
  memset(s, 127, 0xFBCuLL);
  memset(v8, 0, 0xFBCuLL);
  v2 = 0;
  v3 = 1;
  s[a1] = 0;
  v8[a1] = 1;
  qu[0] = a1;
  while ( v2 != v3 )
  {
    v5 = qu[v2++];
    for ( i = head[v5]; i; i = next[i] )
    {
      v6 = to[i];
      if ( s[v6] >= s[v5] + len[i] )
      {
        s[v6] = len[i] + s[v5];
        if ( !v8[v6] )
        {
          v8[v6] = 1;
          qu[v3++] = v6;
          if ( v3 > 1000 )
          {
            puts("queue overflow error!");
            return;
          }
        }
      }
    }
    v8[v5] = 0;
  }
  printf("%d\n", (unsigned int)s[a2]);
}