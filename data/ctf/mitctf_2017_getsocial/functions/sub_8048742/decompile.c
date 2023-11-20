int sub_8048742()
{
  int v1;
  int v2;

  v2 = dword_8049FB8;
  v1 = 0;
  while ( v2 )
  {
    if ( ++v1 == 1000000 )
    {
      system("cat flag");
      exit(0);
    }
    v2 = *(_DWORD *)(v2 + 140);
  }
  return printf("There are %zu tweets\n", v1);
}
