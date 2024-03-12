char map[0x202];
int me;
int dword_8057F84;
int pos;
int dword_8057F8C;
int hp;
int dword_8057F94;
char byte_8057F98[300];
int fd;
char *cp;
int dword_80580CC;
char byte_80580D0[128];
int dword_8058150;
int func_ptr_list[10];
int (*cur_action_ptr)(void);

void cmd_go_back()
{
  cur_action_ptr = show_main_menu;
}

void cmd_move()
{
  cur_action_ptr = show_move_menu;
}

void cmd_build()
{
  cur_action_ptr = show_build_menu;
}

void cmd_settings()
{
  cur_action_ptr = show_settings_menu;
}

void cmd_set_autoview()
{
  dword_80580CC = dword_80580CC == 0;
}

void cmd_multiplayer()
{
  cur_action_ptr = show_multiplayer_menu;
}

void __cdecl __noreturn do_afk(int a1)
{
  __printf_chk(1, "[Info] %s is AFK\n", byte_80580D0);
  exit(0);
}

void show_main_menu()
{
  int i;

  puts("\n-+STARBOUND v1.0+-");
  puts("  0. Exit");
  puts("  1. Info");
  puts("  2. Move");
  puts("  3. View");
  puts("  4. Tools");
  puts("  5. Kill");
  puts("  6. Settings");
  puts("  7. Multiplayer");
  __printf_chk(1, "> ");
  for ( i = 0; i <= 9; ++i )
    func_ptr_list[i] = (int)cmd_nop;
  func_ptr_list[1] = (int)cmd_info;
  func_ptr_list[2] = (int)cmd_move;
  func_ptr_list[3] = (int)cmd_view;
  func_ptr_list[4] = (int)cmd_build;
  func_ptr_list[5] = (int)cmd_kill;
  func_ptr_list[6] = (int)cmd_settings;
  func_ptr_list[7] = (int)cmd_multiplayer;
}

int show_multiplayer_menu()
{
  int result;

  puts("\n-+STARBOUND v1.0: MULTIPLAYER+-");
  puts("  0. Exit");
  puts("  1. Back");
  puts("  2. Enable");
  puts("  3. Disable");
  puts("  4. Teleport");
  puts("  5. Share Your Coordinate");
  __printf_chk(1, "> ");
  for ( result = 0; result <= 9; ++result )
    func_ptr_list[result] = (int)cmd_nop;
  func_ptr_list[1] = (int)cmd_go_back;
  func_ptr_list[2] = (int)cmd_multiplayer_enable;
  func_ptr_list[3] = (int)cmd_multiplayer_disable;
  func_ptr_list[4] = (int)cmd_multiplayer_recvmap;
  func_ptr_list[5] = (int)cmd_multiplayer_sendmap;
  return result;
}

void cmd_nop()
{
  puts("\n\n[TROLLOLL] NOTHING TO DO HERE\n");
}

void cmd_view()
{
  int v0;
  int v1;
  int v2;
  int v3;
  int i;
  char v5;
  char v6;
  int v7;
  int v8;
  int v9;
  bool v10;
  char v11;
  int v12;
  char v13;
  char v14;
  int v15;
  int v16;
  int v17;
  int v18;
  int v19;
  int v20;
  char s[25];
  char v22;
  char v23;
  char v24;
  char v25[130];

  v20 = pos;
  v0 = dword_8057F84;
  v1 = 0;
  v2 = pos;
  while ( v1 <= 50 )
  {
    v3 = (byte_8057F98[((v0 + v1 + v2 - 25) % v0) >> 1] >> (4 * (((v0 + v1 + v2 - 25) % v0) & 1))) & 0xF;
    v25[v1 + 51] = v3;
    if ( (unsigned int)((v0 + v1 + v2 - 25) % v0 - dword_8058150 + 2) <= 4 )
      LOBYTE(v3) = 12;
    v25[v1++] = v3;
  }
  __sprintf_chk(s, 1, 64, " / Pos: %3d HP: %3d", pos, hp);
  for ( i = 17; i >= 0; i = v18 - 1 )
  {
    v15 = 1;
    v16 = i - 2;
    v19 = i - 1;
    v17 = i;
    while ( v15 <= 49 )
    {
      v5 = v25[v15];
      if ( v16 == v5 && v15 == 25 )
      {
        v22 = 111;
      }
      else if ( v5 == v19 && v15 == 25 )
      {
        v22 = 84;
      }
      else
      {
        v6 = v25[v15 + 51];
        if ( v6 == v17 )
        {
          if ( v5 == v6 )
          {
            v7 = v25[v15 + 50];
            if ( v7 >= v17 )
            {
              if ( v17 >= v7 )
              {
                v12 = v25[v15 + 52];
                if ( v12 >= v17 )
                {
                  v10 = v17 < v12;
                  v13 = 45;
                  if ( !v10 )
                    v13 = 95;
                  s[v15] = v13;
                }
                else
                {
                  s[v15] = 126;
                }
              }
              else
              {
                v9 = v25[v15 + 52];
                if ( v9 >= v17 )
                {
                  v10 = v17 < v9;
                  v11 = 118;
                  if ( !v10 )
                    v11 = 96;
                  s[v15] = v11;
                }
                else
                {
                  s[v15] = 92;
                }
              }
            }
            else
            {
              v8 = v25[v15 + 52];
              if ( v8 >= v17 )
                s[v15] = 3 * (v17 < v8) + 44;
              else
                s[v15] = 94;
            }
          }
          else
          {
            s[v15] = 119;
          }
        }
        else if ( v17 <= v6 )
        {
          if ( ((v15 + v20) ^ (me >> v17)) == 20 * (((v15 + v20) ^ (me >> v17)) / 20) )
            s[v15] = (v20 + v17 + v15) % 5 == 0 ? 64 : 35;
          else
            s[v15] = 46;
        }
        else if ( v17 != 17 )
        {
          if ( v17 <= v5 )
          {
            v14 = 32;
            if ( v5 != v6 )
              v14 = 77;
            s[v15] = v14;
          }
          else
          {
            s[v15] = 32;
          }
        }
      }
      ++v15;
    }
    v18 = v17;
    if ( v17 != 17 )
    {
      s[0] = 124;
      v23 = 124;
    }
    v24 = 0;
    puts(s);
  }
  puts(" \\_______________________________________________/\n");
}

void show_move_menu()
{
  int i;

  if ( dword_80580CC )
    cmd_view();
  puts("\n-+STARBOUND v1.0: MOVE+-");
  puts("  0. Exit");
  puts("  1. Back");
  puts("  2. Left");
  puts("  3. Right");
  puts("  4. Jump");
  __printf_chk(1, "> ");
  for ( i = 0; i <= 9; ++i )
    func_ptr_list[i] = (int)cmd_nop;
  func_ptr_list[1] = (int)cmd_go_back;
  func_ptr_list[2] = (int)cmd_move_left;
  func_ptr_list[3] = (int)cmd_move_right;
  func_ptr_list[4] = (int)cmd_move_jump;
}

void show_build_menu()
{
  int i;

  if ( dword_80580CC )
    cmd_view();
  puts("\n-+STARBOUND v1.0: TOOLS+-");
  puts("  0. Exit");
  puts("  1. Back");
  puts("  2. Pickaxe");
  puts("  3. Cobblestone");
  __printf_chk(1, "> ");
  for ( i = 0; i <= 9; ++i )
    func_ptr_list[i] = (int)cmd_nop;
  func_ptr_list[1] = (int)cmd_go_back;
  func_ptr_list[2] = (int)cmd_build_dig;
  func_ptr_list[3] = (int)cmd_build_place;
}

void show_settings_menu()
{
  int i;

  if ( dword_80580CC )
    cmd_view();
  puts("\n-+STARBOUND v1.0: SETTINGS+-");
  puts("  0. Exit");
  puts("  1. Back");
  puts("  2. Name");
  puts("  3. IP");
  puts("  4. Toggle View");
  __printf_chk(1, "> ");
  for ( i = 0; i <= 9; ++i )
    func_ptr_list[i] = (int)cmd_nop;
  func_ptr_list[1] = (int)cmd_go_back;
  func_ptr_list[2] = (int)cmd_set_name;
  func_ptr_list[3] = (int)cmd_set_ip;
  func_ptr_list[4] = (int)cmd_set_autoview;
}

void cmd_multiplayer_enable()
{
  __pid_t v0;
  socklen_t len;
  struct sockaddr addr;

  if ( fd != -1 )
    close(fd);
  addr.sa_family = 1;
  fd = socket(1, 2, 0);
  if ( fd < 0
    || (mkdir("/home/starbound/.multiplayer", 0x1C0u),
        v0 = getpid(),
        __sprintf_chk(addr.sa_data, 1, 108, "/home/starbound/.multiplayer/%d", v0),
        unlink(addr.sa_data),
        bind(fd, &addr, 0x6Eu) < 0)
    || (len = 110, getsockname(fd, &addr, &len) < 0) )
  {
    puts("[Error] Fail to enable");
    close(fd);
  }
  else
  {
    __printf_chk(1, "[Info] Portal %d enabled\n", v0);
  }
}

void init_map()
{
  int v0;
  signed int v1;
  int i;
  char v3;
  int j;
  int k;
  int v6;
  int m;
  int v8;
  signed int v9;
  int v10;
  int v11;
  int v12;
  int n;

  v0 = rand();
  v1 = (v0 % 400 + 100) & 0xFFFFFFFE;
  __memset_chk(&map[2], 0, v1, 512);
  for ( i = 0; v1 - 4 > i; i += 4 )
  {
    v3 = rand() & 7;
    for ( j = 0; j <= 7; ++j )
      map[i + 2 + j] += v3;
  }
  dword_8058150 = (v1 >> 1) + rand() % 20;
  for ( k = 1; v1 - 1 > k; ++k )
  {
    v6 = map[k + 3] + map[k + 1] + 2 * map[k + 2];
    map[k + 2] = (v6 + (rand() & 1)) >> 2;
  }
  map[2] = (map[v1 + 1] + 2 * map[2] + map[3]) >> 2;
  map[v1 + 1] = (map[v1] + 2 * map[v1 + 1] + map[2]) >> 2;
  for ( m = 0; m <= 30; ++m )
  {
    v8 = (dword_8058150 + m) % v1;
    v9 = 16 - abs32(m - 15) + rand() % 2;
    if ( v9 >= 14 )
      v9 = 13;
    if ( map[v8 + 2] < v9 )
      map[v8 + 2] = v9;
    if ( (unsigned int)(m - 13) <= 4 )
    {
      v10 = (unsigned __int8)map[v8 + 2];
      v11 = rand();
      v12 = v10 - (((v11 < 0) + (_BYTE)v11) & 1) + ((unsigned int)v11 >> 31) - 2;
      if ( (v12 & 0x80u) != 0 )
        LOBYTE(v12) = 0;
      map[v8 + 2] = v12;
    }
  }
  dword_8058150 += 15;
  for ( n = 0; v1 >> 1 > n; ++n )
    byte_8057F98[n] = map[2 * n + 2] + 16 * map[2 * n + 3];
  dword_8057F84 = (v0 % 400 + 100) & 0xFFFFFFFE;
}

void init()
{
  int v0;
  char *v1;
  int v2;
  int seed[4];

  setvbuf(stdin, 0, 2, 0);
  setvbuf(stdout, 0, 2, 0);
  setvbuf(stderr, 0, 2, 0);
  signal(14, (__sighandler_t)do_afk);
  puts("[Info] Landing ...");
  usleep(0x7A120u);
  v0 = open("/dev/urandom", 0);
  read(v0, seed, 4u);
  close(v0);
  srand(seed[0]);
  me = seed[0];
  init_map();
  pos = rand() % dword_8057F84;
  dword_8057F8C = 0;
  hp = 100;
  dword_8057F94 = 0;
  v1 = getenv("REMOTE_HOST");
  if ( !v1 )
    v1 = "127.0.0.1";
  cp = (char *)malloc(strlen(v1) + 1);
  fd = -1;
  dword_80580CC = 0;
  strcpy(cp, v1);
  v2 = rand();
  __strcpy_chk(byte_80580D0, name_list[v2 % 2826], 128);
  cmd_view();
  cmd_go_back();
}

void cleanup_sun()
{
  __pid_t v0;
  char name[116];

  v0 = getpid();
  __sprintf_chk(name, 1, 104, "/home/starbound/.multiplayer/%d", v0);
  unlink(name);
}

void cmd_multiplayer_disable()
{
  if ( fd >= 0 )
  {
    close(fd);
    cleanup_sun();
  }
  puts("[Info] Portal disabled");
}

ssize_t __cdecl readn(void *buf, size_t nbytes)
{
  ssize_t result;

  result = read(0, buf, nbytes);
  if ( result <= 0 )
    exit(0);
  return result;
}

ssize_t cmd_set_name()
{
  ssize_t result;

  __printf_chk(1, "Enter your name: ");
  result = readn(byte_80580D0, 0x64u);
  *(_BYTE *)(result + 134578383) = 0;
  return result;
}

void cmd_set_ip()
{
  size_t n;
  char src[268];

  __printf_chk(1, "Enter your IP address: ");
  n = readn(src, 0x100u);
  free(cp);
  cp = (char *)malloc(n);
  memcpy(cp, src, n);
  cp[n - 1] = 0;
}

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

void cmd_info()
{
  int i;
  char v1[28];

  get_server_key((int)v1);
  puts("\n-+STARBOUND v1.0: INFORMATION+-");
  __printf_chk(1, " |  Server ID: ");
  for ( i = 0; i <= 15; ++i )
    __printf_chk(1, "%02X", (unsigned __int8)v1[i]);
  puts("");
  __printf_chk(1, " |  Seed: %08X\n", me);
  __printf_chk(1, " |  Size: %d\n", dword_8057F84);
  __printf_chk(1, " +  Player: %s (from %s)\n", byte_80580D0, cp);
  __printf_chk(1, " |  Position: %d\n", pos);
  __printf_chk(1, " |  HP: %d\n", hp);
  __printf_chk(1, " |  Cobblestone: %d\n", dword_8057F8C);
  __printf_chk(1, " |  Score: %d\n", dword_8057F94);
  puts("");
}

void do_bye()
{
  __printf_chk(1, "Goodbye, %s\n", byte_80580D0);
}

void __cdecl do_send_record(void *buf, size_t n)
{
  int v2;
  struct sockaddr addr;

  v2 = socket(2, 1, 0);
  *(_DWORD *)&addr.sa_data[2] = inet_addr(cp);
  addr.sa_family = 2;
  *(_WORD *)addr.sa_data = 27002;
  if ( connect(v2, &addr, 0x10u) >= 0 )
  {
    write(v2, buf, n);
    puts("[Info] Record sended.");
  }
  else
  {
    puts("[Error] Fail to send your record. Make sure that you are listening 31337.");
  }
  close(v2);
}

void __cdecl __noreturn do_die(const char *a1)
{
  int v1;
  char buf[1036];

  __printf_chk(1, a1);
  puts("");
  __printf_chk(1, "Save your record? (y/n)");
  read(0, buf, 0x400u);
  if ( buf[0] == 121 )
  {
    v1 = __sprintf_chk(buf, 1, 1024, "Map seed: %08X\nScore: %d\n", me, dword_8057F94);
    memcpy(&buf[v1], byte_8057F98, dword_8057F84 >> 1);
    do_send_record(buf, 0x400u);
  }
  do_bye();
  exit(0);
}

void __noreturn cmd_kill()
{
  char v1[268];

  __printf_chk(1, "Why???? ");
  v1[readn(v1, 0x100u) - 1] = 0;
  do_die(v1);
}

void check_pos()
{
  int v0;

  v0 = abs32(pos - dword_8058150);
  if ( v0 > 2 )
  {
    if ( v0 <= 9 )
    {
      puts("So hot!!");
      if ( --hp <= 0 )
        do_die("*Burned to death*");
    }
  }
  else
  {
    puts("TttsSSSss ... lava is good for you.");
    hp -= 40;
    if ( hp <= 0 )
      do_die("*Tried to swim in lava*");
  }
}

void cmd_move_left()
{
  int v0;

  v0 = pos - 1;
  pos = v0;
  if ( v0 < 0 )
    pos = dword_8057F84 + v0;
  puts("[Info] Moved left...");
  check_pos();
}

void cmd_move_right()
{
  int v0;

  v0 = pos + 1;
  pos = v0;
  if ( v0 >= dword_8057F84 )
    pos = v0 - dword_8057F84;
  puts("[Info] Moved right...");
  check_pos();
}

void cmd_move_jump()
{
  bool v0;
  int v1;
  int v2;
  int v3;
  char s[22];

  __printf_chk(1, "left or right? ");
  fgets(s, 10, stdin);
  v0 = memcmp(s, "left", 4u) == 0;
  v1 = pos;
  if ( v0 )
  {
    pos = v1 + rand() % 100 + 100;
  }
  else
  {
    v2 = rand();
    pos = v1 + 100 * (v2 / 100) - v2 - 100;
  }
  v3 = pos % dword_8057F84;
  pos = v3;
  if ( v3 < 0 )
    pos = v3 + dword_8057F84;
  __printf_chk(1, "Iku~~ ");
  sleep(1u);
  putchar(46);
  sleep(1u);
  putchar(46);
  sleep(1u);
  puts(".");
  __printf_chk(1, "Landing .");
  sleep(1u);
  putchar(46);
  sleep(1u);
  putchar(46);
  puts(" Ouch!");
  check_pos();
}

void cmd_build_dig()
{
  int v0;
  char v1;

  if ( (int)abs32(pos - dword_8058150) > 9 )
  {
    v0 = pos >> 1;
    v1 = byte_8057F98[pos >> 1];
    if ( ((v1 >> (4 * (pos & 1))) & 0xF) != 0 )
    {
      if ( (pos & 1) != 0 )
        byte_8057F98[v0] = v1 - 16;
      else
        byte_8057F98[v0] = v1 - 1;
      ++dword_8057F8C;
      ++dword_8057F94;
      puts("[Info] Dig..dig..dig..");
    }
    else
    {
      puts(">Crash< ... so hard!");
    }
  }
  else
  {
    check_pos();
  }
}

void cmd_build_place()
{
  int v0;
  char v1;
  int v2;

  v0 = pos >> 1;
  v1 = byte_8057F98[pos >> 1];
  if ( (int)abs32(pos - dword_8058150) > 9 )
  {
    if ( ((byte_8057F98[pos >> 1] >> (4 * (pos & 1))) & 0xF) == 15 )
    {
      puts("I can't breathe anymore!!");
      hp -= 10;
      if ( hp <= 0 )
        do_die("*Suffocated*");
    }
    else
    {
      v2 = dword_8057F8C;
      if ( dword_8057F8C <= 0 )
      {
        puts("No more cobblestone :(");
      }
      else
      {
        if ( (pos & 1) != 0 )
          byte_8057F98[v0] = v1 + 16;
        else
          byte_8057F98[v0] = v1 + 1;
        dword_8057F8C = v2 - 1;
        ++dword_8057F94;
      }
    }
  }
  else
  {
    check_pos();
  }
}

int __cdecl rotate_shift_add_encrypt(int a1, _DWORD *a2)
{
  int v2;

  v2 = (unsigned __int16)((2 * *a2) | (*a2 >> 15));
  *a2 = v2;
  return (a1 + v2) % 95 + 32;
}

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

int __cdecl rotate_shift_add_decrypt(int a1, _DWORD *a2)
{
  int v2;
  int result;

  v2 = (unsigned __int16)((2 * *a2) | (*a2 >> 15));
  *a2 = v2;
  result = (a1 - v2 - 32) % 95 + ((a1 - v2 - 32) % 95 < 0 ? 0x5F : 0);
  if ( result <= 31 )
    result += 95;
  return result;
}

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

int __cdecl main(int argc, const char **argv, const char **envp)
{
  int v3;
  char nptr[256];

  init();
  while ( 1 )
  {
    cur_action_ptr();
    if ( !readn(nptr, 0x100u) )
      break;
    v3 = strtol(nptr, 0, 10);
    if ( !v3 )
      break;
    ((void (*)(void))func_ptr_list[v3])();
  }
  do_bye();
  return 0;
}