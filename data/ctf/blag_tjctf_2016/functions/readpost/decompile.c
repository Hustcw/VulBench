unsigned int readpost()
{
  int v1;
  int v2;
  char v3[8];
  unsigned int v4;

  v4 = __readgsdword(0x14u);
  puts("Index?");
  readline(v3, 8, (FILE *)stdin);
  __isoc99_sscanf(v3, "%d", &v1);
  if ( v1 < numposts && v1 >= 0 )
  {
    v2 = (int)*(&posts + v1);
    if ( isadmin || !*(_DWORD *)v2 )
      printf("%s by %s:\n%s\n", (const char *)(v2 + 36), (const char *)(v2 + 4), (const char *)(v2 + 68));
    else
      puts("Admin only!");
  }
  else
  {
    puts("Invalid index!");
  }
  return __readgsdword(0x14u) ^ v4;
}
