void cmd_multiplayer_sendmap()
{
  int v0;
  int i;
  _BYTE *v2;
  char v3;
  int j;
  int k;
  int v6;
  int v7;
  char nptr[10];
  void *ptr;
  int v10;
  struct sockaddr addr;

  __printf_chk(1, "Your friend's portal ID: ");
  fgets(nptr, 10, stdin);
  v10 = strtol(nptr, 0, 10);
  v0 = socket(1, 2, 0);
  addr.sa_family = 1;
  __sprintf_chk(addr.sa_data, 1, 108, "/home/starbound/.multiplayer/%d", v10);
  __printf_chk(1, "Make some comments: ");
  ptr = 0;
  v7 = 0;
  v6 = getline(&ptr, &v7, stdin);
  for ( i = 0; i < v6; ++i )
  {
    v2 = (char *)ptr + i;
    v3 = *((_BYTE *)ptr + i);
    if ( (unsigned __int8)(v3 - 32) > 0x5Eu )
    {
      *v2 = 10;
      sendto(v0, (char *)ptr + i, 1u, 0, &addr, 0x6Eu);
      break;
    }
    *v2 = rotate_shift_add_encrypt(v3, &v10);
    sendto(v0, (char *)ptr + i, 1u, 0, &addr, 0x6Eu);
  }
  free(ptr);
  for ( j = 0; j <= 1; ++j )
    sendto(v0, (char *)&dword_8057F84 + j, 1u, 0, &addr, 0x6Eu);
  for ( k = 0; dword_8057F84 / 2 > k; ++k )
    sendto(v0, &byte_8057F98[k], 1u, 0, &addr, 0x6Eu);
  close(v0);
  puts("[Info] Completed");
}