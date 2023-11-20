void sub_E98()
{
  int v0;
  unsigned int v1;
  int v2;
  unsigned int v3;
  int v4;

  printf("index: ");
  v1 = sub_BE0(v0);
  v3 = v1;
  if ( v1 <= 0xF && games[v1].used == 1 )
  {
    printf("size: ");
    v2 = sub_BE0(1);
    v4 = sub_E3C(games[v3].size, v2);
    if ( v2 > 0 )
    {
      printf("content: ");
      sub_DA8(games[v3].content, v4);
    }
  }
}