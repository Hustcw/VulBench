void sub_1138()
{
  int v0;
  unsigned int v1;

  printf("index: ");
  v1 = sub_BE0(v0);
  if ( v1 <= 0xF && games[v1].used == 1 )
  {
    printf("content: ");
    print(games[v1].content, games[v1].size);
  }
}