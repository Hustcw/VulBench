int visit()
{
  __int64 v0;
  unsigned int i;

  LODWORD(v0) = flowercount;
  if ( flowercount )
  {
    for ( i = 0; i <= 0x63; ++i )
    {
      v0 = flowerlist[i];
      if ( v0 )
      {
        LODWORD(v0) = *(_DWORD *)flowerlist[i];
        if ( (_DWORD)v0 )
        {
          printf("Name of the flower[%u] :%s\n", i, *(const char **)(flowerlist[i] + 8LL));
          LODWORD(v0) = printf("Color of the flower[%u] :%s\n", i, (const char *)(flowerlist[i] + 16LL));
        }
      }
    }
  }
  else
  {
    LODWORD(v0) = puts("No flower in the garden !");
  }
  return v0;
}
