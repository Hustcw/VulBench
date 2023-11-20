void __cdecl calc_md5(char *a1, char *a2, int with_salt)
{
  unsigned __int8 *v3;
  size_t v4;
  int i;
  int j;
  const char *s;
  char v8[92];
  char v9[16];
  unsigned int v10;

  v10 = __readgsdword(0x14u);
  if ( with_salt )
  {
    s = a1 - 4;
    for ( i = 0; i <= 3; ++i )
    {
      v3 = &struc->salt_ptr[i];
      *v3 = rand();
      if ( !struc->salt_ptr[i] )
        ++struc->salt_ptr[i];
    }
  }
  else
  {
    s = a1;
  }
  if ( MD5_Init(v8) != 1 )
  {
    perror("MD5_Init");
    exit(1);
  }
  v4 = strlen(s);
  if ( MD5_Update(v8, s, v4) != 1 )
  {
    perror("MD5_Update");
    exit(1);
  }
  if ( MD5_Final(v9, v8) != 1 )
  {
    perror("MD5_Final");
    exit(1);
  }
  for ( j = 0; j <= 15; ++j )
    sprintf(&a2[2 * j], "%02x", (unsigned __int8)v9[j]);
}