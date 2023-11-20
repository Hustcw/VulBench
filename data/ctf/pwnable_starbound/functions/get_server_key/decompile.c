int __cdecl get_server_key(int a1)
{
  int v1;
  int i;
  char v4[92];
  char v5[524];

  memset(v5, 0, 0x200u);
  v1 = open("/home/starbound/hint", 0);
  for ( i = 0; i <= 511; i += 32 )
  {
    read(v1, &v5[i], 0x20u);
    lseek(v1, 0, 0);
  }
  memfrob(v5, 512);
  MD5_Init(v4);
  MD5_Update(v4, v5, 512);
  return MD5_Final(a1, v4);
}
