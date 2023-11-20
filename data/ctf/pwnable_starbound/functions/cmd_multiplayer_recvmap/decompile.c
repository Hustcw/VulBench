int cmd_multiplayer_recvmap()
{
  int v0;
  int i;
  int v3;
  char *v4;
  __pid_t v5;
  int v6;
  char buf[13];

  v5 = getpid();
  puts("Ask your friends to share their coordinates!");
  v0 = 1;
  while ( 1 )
  {
    if ( read(fd, buf, 1u) <= 0 )
      return puts("[Error] Transmission error :(");
    if ( buf[0] == 10 )
      break;
    buf[0] = rotate_shift_add_decrypt(buf[0], &v5);
    if ( v0 )
    {
      __printf_chk(1, "[Info] Receiving (");
      v0 = 0;
    }
    putchar(buf[0]);
  }
  puts(")");
  __printf_chk(1, "[Info] Calculate distance ... ");
  v6 = 0;
  for ( i = 0; i <= 1; ++i )
  {
    if ( read(fd, &buf[i - 1], 1u) <= 0 )
      exit(0);
  }
  __printf_chk(1, "%dly\n", v6);
  puts("Start teleporting!");
  dword_8057F84 = v6;
  v6 /= 2;
  v3 = 0;
  v4 = byte_8057F98;
  while ( v3 < v6 )
  {
    if ( read(fd, v4, 1u) <= 0 )
      exit(0);
    ++v4;
    ++v3;
  }
  dword_8057F88 %= dword_8057F84;
  puts("Landing ...");
  usleep(0x7A120u);
  return cmd_view();
}
