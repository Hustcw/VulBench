void sub_FA4()
{
  int v0;
  int v1;
  int v2;

  printf("index: ");
  v0 = sub_BE0(v2);
  v1 = v0;
  if ( (unsigned __int64)v0 <= 0xF && games[v0].used == 1LL )
  {
    games[v0].used = 0;
    games[v0].size = 0;
    free(games[v0].content);
    games[v1].content = 0LL;
  }
}