__int64 __fastcall sub_985(unsigned int *a1, unsigned int a2, int a3)
{
  int v3;
  int v5;
  unsigned int v6;
  unsigned int v7;
  unsigned int v8;
  unsigned int v9;

  v7 = a1[a2];
  v5 = a2 + 1;
  v6 = a2;
  while ( v5 <= a3 )
  {
    v3 = v5++;
    if ( a1[v3] < v7 )
    {
      v8 = a1[++v6];
      a1[v6] = a1[v5 - 1];
      a1[v5 - 1] = v8;
    }
  }
  v9 = a1[v6];
  a1[v6] = v7;
  a1[a2] = v9;
  return v6;
}