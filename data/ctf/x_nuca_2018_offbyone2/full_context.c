char *byte_2020C0[16];

void __fastcall sub_B20(char *a1, unsigned int a2)
{
  char buf;
  unsigned int i;
  unsigned __int64 v4;

  v4 = __readfsqword(0x28u);
  for ( i = 0; i < a2; ++i )
  {
    buf = 0;
    if ( read(0, &buf, 1uLL) < 0 )
    {
      puts("Read error.");
      exit(-2);
    }
    if ( buf == 10 )
    {
      a1[i] = 0;
      return;
    }
    a1[i] = buf;
  }
  a1[i] = 0;
}

void sub_C0E()
{
  int v0;
  int i;
  unsigned __int64 v2;

  v2 = __readfsqword(0x28u);
  for ( i = 0; i <= 15 && byte_2020C0[i]; ++i )
    ;
  if ( i <= 15 )
  {
    printf("length: ");
    __isoc99_scanf("%d", &v0);
    if ( v0 > 127 && v0 <= 0x10000 )
    {
      byte_2020C0[i] = (char *)malloc(v0);
      if ( !byte_2020C0[i] )
      {
        puts("malloc failed.");
        exit(-1);
      }
      memset(byte_2020C0[i], 0, v0);
      puts("your note:");
      sub_B20(byte_2020C0[i], (unsigned int)v0);
      puts("done.");
    }
    else
    {
      puts("invalid size");
    }
  }
  else
  {
    puts("you can't add anymore.");
  }
}

void sub_D73()
{
  unsigned int v0;
  unsigned __int64 v1;

  v1 = __readfsqword(0x28u);
  printf("index: ");
  __isoc99_scanf("%d", &v0);
  if ( v0 <= 0xF && byte_2020C0[v0] )
  {
    free(byte_2020C0[v0]);
    byte_2020C0[v0] = 0LL;
    puts("done.");
  }
  else
  {
    puts("invalid index.");
  }
}

void sub_E37()
{
  unsigned int v0;
  unsigned __int64 v1;

  v1 = __readfsqword(0x28u);
  printf("index: ");
  __isoc99_scanf("%d", &v0);
  if ( v0 <= 0xF && byte_2020C0[v0] )
  {
    puts(byte_2020C0[v0]);
    puts("done.");
  }
  else
  {
    puts("invalid index.");
  }
}

void __fastcall __noreturn main(int a1, char **a2, char **a3)
{
  int v3;

  while ( 1 )
  {
    __isoc99_scanf("%d", &v3);
    switch ( v3 )
    {
      case 2:
        sub_D73();
        break;
      case 3:
        sub_E37();
        break;
      case 1:
        sub_C0E();
        break;
      default:
        puts("invalid~");
        break;
    }
  }
}