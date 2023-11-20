int __fastcall sub_153B(__int64 a1)
{
  int v2;
  int v3;
  unsigned int v4;
  int v5;

  printf("Please input the red packet idx: ");
  v4 = sub_14F5();
  if ( v4 > 0x10 )
    sub_1521();
  printf("How much do you want?(1.0x10 2.0xf0 3.0x300 4.0x400): ");
  v3 = sub_14F5();
  if ( v3 == 2 )
  {
    v5 = 240;
  }
  else if ( v3 > 2 )
  {
    if ( v3 == 3 )
    {
      v5 = 768;
    }
    else
    {
      if ( v3 != 4 )
        goto LABEL_14;
      v5 = 1024;
    }
  }
  else
  {
    if ( v3 != 1 )
    {
LABEL_14:
      v5 = 0;
      goto LABEL_15;
    }
    v5 = 16;
  }
LABEL_15:
  if ( v5 != 16 && v5 != 240 && v5 != 768 && v5 != 1024 )
    sub_1521();
  *(_QWORD *)(16LL * v4 + a1) = calloc(1uLL, v5);
  *(_DWORD *)(a1 + 16LL * v4 + 8) = v5;
  printf("Please input content: ");
  v2 = read(0, *(void **)(16LL * v4 + a1), *(int *)(16LL * v4 + a1 + 8));
  if ( v2 <= 0 )
    sub_1521();
  *(_BYTE *)(v2 - 1LL + *(_QWORD *)(16LL * v4 + a1)) = 0;
  return puts("Done!");
}
