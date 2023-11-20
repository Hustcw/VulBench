void __cdecl get_server_key(int a1)
{
  int v1;
  int i;
  char v3[92];
  char v4[524];

  memset(v4, 0, 0x200u);
  v1 = open("/home/starbound/hint", 0);
  for ( i = 0; i <= 511; i += 32 )
  {
    read(v1, &v4[i], 0x20u);
    lseek(v1, 0, 0);
  }
  memfrob(v4, 512);
  MD5_Init(v3);
  MD5_Update(v3, v4, 512);
  MD5_Final(a1, v3);
}