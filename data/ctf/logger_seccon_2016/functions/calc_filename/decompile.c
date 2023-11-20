__int64 __fastcall calc_filename(const char *a1, const char *a2, __int64 a3)
{
  size_t v3;
  int i;
  char v7[96];
  char v8[16];
  char dest[2];
  __int16 v10;
  int v11;
  _BYTE v12[120];
  unsigned __int64 v13;

  v13 = __readfsqword(0x28u);
  *(_WORD *)dest = 0;
  v10 = 0;
  v11 = 0;
  memset(v12, 0, sizeof(v12));
  strcat(dest, a1);
  strcat(dest, a2);
  if ( (unsigned int)MD5_Init(v7) != 1 )
  {
    puts("Initialization error.");
    exit(1);
  }
  v3 = strlen(dest);
  if ( (unsigned int)MD5_Update(v7, dest, v3) != 1 )
  {
    puts("Update error.");
    exit(1);
  }
  if ( (unsigned int)MD5_Final(v8, v7) != 1 )
  {
    puts("Finalization error.");
    exit(1);
  }
  for ( i = 0; i <= 15; ++i )
    sprintf((char *)(a3 + 2 * i), "%02x", (unsigned __int8)v8[i]);
  return a3;
}
