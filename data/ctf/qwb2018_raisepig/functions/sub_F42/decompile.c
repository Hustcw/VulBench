unsigned __int64 sub_F42()
{
  unsigned int i;
  unsigned __int64 v2;

  v2 = __readfsqword(0x28u);
  for ( i = 0; i <= 0x63; ++i )
  {
    if ( qword_202040[i] && !*(_DWORD *)qword_202040[i] )
    {
      free((void *)qword_202040[i]);
      qword_202040[i] = 0LL;
      --dword_20202C;
    }
  }
  puts("Done!");
  return __readfsqword(0x28u) ^ v2;
}
