void __fastcall get(RedPacket *a1)
{
  int v1;
  int v2;
  unsigned int v3;
  int v4;

  printf("Please input the red packet idx: ");
  v3 = read_int();
  if ( v3 > 0x10 )
    exit_();
  printf("How much do you want?(1.0x10 2.0xf0 3.0x300 4.0x400): ");
  v2 = read_int();
  if ( v2 == 2 )
  {
    v4 = 240;
  }
  else if ( v2 > 2 )
  {
    if ( v2 == 3 )
    {
      v4 = 768;
    }
    else
    {
      if ( v2 != 4 )
        goto LABEL_14;
      v4 = 1024;
    }
  }
  else
  {
    if ( v2 != 1 )
    {
LABEL_14:
      v4 = 0;
      goto LABEL_15;
    }
    v4 = 16;
  }
LABEL_15:
  if ( v4 != 16 && v4 != 240 && v4 != 768 && v4 != 1024 )
    exit_();
  a1[v3].content = (char *)calloc(1uLL, v4);
  a1[v3].size = v4;
  printf("Please input content: ");
  v1 = read(0, a1[v3].content, a1[v3].size);
  if ( v1 <= 0 )
    exit_();
  a1[v3].content[v1 - 1] = 0;
  puts("Done!");
}