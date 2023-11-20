__int64 sub_101E()
{
  unsigned int i;

  if ( dword_20202C )
  {
    for ( i = 0; i <= 0x63; ++i )
    {
      if ( qword_202040[i] && *(_DWORD *)qword_202040[i] )
      {
        printf("Name[%u] :%s\n", i, *(const char **)(qword_202040[i] + 8LL));
        printf("Type[%u] :%s\n", i, (const char *)(qword_202040[i] + 16LL));
      }
    }
  }
  else
  {
    puts("No pig in the garden !");
  }
  return 0LL;
}
