void cmd_multiplayer_recvmap()
{
  int v0;
  int i;
  int v2;
  char *v3;
  __pid_t v4;
  int v5;
  char buf[13];

  v4 = getpid();
  puts("Ask your friends to share their coordinates!");
  v0 = 1;
  while ( 1 )
  {
    if ( read(fd, buf, 1u) <= 0 )
    {
      puts("[Error] Transmission error :(");
      return;
    }
    if ( buf[0] == 10 )
      break;
    buf[0] = rotate_shift_add_decrypt(buf[0], &v4);
    if ( v0 )
    {
      __printf_chk(1, "[Info] Receiving (");
      v0 = 0;
    }
    putchar(buf[0]);
  }
  puts(")");
  __printf_chk(1, "[Info] Calculate distance ... ");
  v5 = 0;
  for ( i = 0; i <= 1; ++i )
  {
    if ( read(fd, &buf[i - 1], 1u) <= 0 )
      exit(0);
  }
  __printf_chk(1, "%dly\n", v5);
  puts("Start teleporting!");
  dword_8057F84 = v5;
  v5 /= 2;
  v2 = 0;
  v3 = byte_8057F98;
  while ( v2 < v5 )
  {
    if ( read(fd, v3, 1u) <= 0 )
      exit(0);
    ++v3;
    ++v2;
  }
  pos %= dword_8057F84;
  puts("Landing ...");
  usleep(0x7A120u);
  cmd_view();
}