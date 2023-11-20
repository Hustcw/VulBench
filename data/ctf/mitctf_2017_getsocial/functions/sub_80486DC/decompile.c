int sub_80486DC()
{
  int v1;
  int v2;

  v2 = dword_8049FB8;
  v1 = 0;
  puts("######");
  while ( v2 )
  {
    printf("Tweet %d: %s\n", v1, (const char *)v2);
    v2 = *(_DWORD *)(v2 + 140);
    ++v1;
  }
  return puts("######");
}
