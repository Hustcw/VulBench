int clean()
{
  unsigned int i;

  for ( i = 0; i <= 0x63; ++i )
  {
    if ( flowerlist[i] && !*(_DWORD *)flowerlist[i] )
    {
      free((void *)flowerlist[i]);
      flowerlist[i] = 0LL;
      --flowercount;
    }
  }
  return puts("Done!");
}
