struct RedPacket
{
  char *content;
  int size;
  int field_C;
};

__int64 qword_4050;
__int64 qword_4058;
RedPacket red_packet_list[16];
struct RedPacket
{
  char *content;
  int size;
  int field_C;
};

__int64 qword_4050;
__int64 qword_4058;
RedPacket red_packet_list[16];

void init_0()
{
  setbuf(stdin, 0LL);
  setbuf(stdout, 0LL);
  setbuf(stderr, 0LL);
  qword_4058 = (__int64)malloc(0x1000uLL);
  if ( !qword_4058 )
  {
    puts("What?");
    exit(-1);
  }
  qword_4050 = qword_4058 & 0xFFFFFFFFFFFFF000LL;
  memset(red_packet_list, 0, sizeof(red_packet_list));
  alarm(0x1Eu);
}

void backdoor()
{
  char buf[128];

  if ( *(__int64 *)(qword_4058 + 2048) <= 0x7F0000000000LL
    || *(_QWORD *)(qword_4058 + 2040)
    || *(_QWORD *)(qword_4058 + 2056) )
  {
    exit_();
  }
  puts("You get red packet!");
  printf("What do you want to say?");
  read(0, buf, 0x90uLL);
}

void menu()
{
  puts("1.Get red packets");
  puts("2.Throw red packets");
  puts("3.change red packets");
  puts("4.watch red packets");
  puts("5.Goodbye");
  printf("Your input: ");
}

int read_int(void)
{
  char buf[16];

  read(0, buf, 0x10uLL);
  return atoi(buf);
}

void __noreturn exit_()
{
  puts("You don't want red packets!");
  exit(0);
}

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

void __fastcall throw(RedPacket *a1)
{
  unsigned int v1;

  printf("Please input the red packet idx: ");
  v1 = read_int();
  if ( v1 > 0x10 || !a1[v1].content )
    exit_();
  free(a1[v1].content);
  puts("Done!");
}

int __fastcall change(RedPacket *a1)
{
  int v2;
  unsigned int v3;

  if ( qword_4010 <= 0 )
    exit_();
  --qword_4010;
  printf("Please input the red packet idx: ");
  v3 = read_int();
  if ( v3 > 0x10 || !a1[v3].content )
    exit_();
  printf("Please input content: ");
  v2 = read(0, a1[v3].content, a1[v3].size);
  if ( v2 <= 0 )
    exit_();
  a1[v3].content[v2 - 1] = 0;
  return puts("Done!");
}

void __fastcall watch(RedPacket *a1)
{
  unsigned int v1;

  printf("Please input the red packet idx: ");
  v1 = read_int();
  if ( v1 > 0x10 || !a1[v1].content )
    exit_();
  puts(a1[v1].content);
  puts("Done!");
}

void __fastcall __noreturn main(__int64 a1, char **a2, char **a3)
{
  int v3;

  sub_128F();
  while ( 1 )
  {
    while ( 1 )
    {
      while ( 1 )
      {
        menu();
        v3 = read_int();
        if ( v3 != 3 )
          break;
        change(red_packet_list);
      }
      if ( v3 > 3 )
        break;
      if ( v3 == 1 )
      {
        if ( get_tries <= 0 )
          exit_();
        get(red_packet_list);
        --get_tries;
      }
      else
      {
        if ( v3 != 2 )
          goto LABEL_19;
        throw(red_packet_list);
      }
    }
    if ( v3 == 5 )
      exit_();
    if ( v3 < 5 )
    {
      watch(red_packet_list);
    }
    else
    {
      if ( v3 != 666 )
LABEL_19:
        exit_();
      backdoor();
    }
  }
}
