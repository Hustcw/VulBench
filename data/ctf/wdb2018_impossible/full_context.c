int dword_602060;
char byte_602068[24];
char byte_602080[4096];
int dword_602060;
char byte_602068[24];
char byte_602080[4096];

void sub_4008A3()
{
  int fd;
  char buf[8];
  unsigned __int64 v2;

  v2 = __readfsqword(0x28u);
  memset(byte_602068, 0, 8uLL);
  fd = open("/dev/urandom", 0);
  read(fd, byte_602068, 8uLL);
  printf("Input your secret code:");
  read(0, buf, 8uLL);
  if ( !memcmp(byte_602068, buf, 8uLL) )
  {
    puts("Amazing! How can u know the secret code?");
    puts("Ok,u are the boss, u can do anything u want");
    puts("But u should be quiet about this, because this is illegal");
    puts("So...Close ur mouth...");
    close(0);
    qmemcpy(buf, byte_602080, 0x1000uLL);
  }
}

void sub_400999()
{
  char buf[2];

  puts("Ok, as u r bored, do something boring to make u more bored...");
  read(0, &byte_602080, 0x1000uLL);
  puts("Satisfied?y/n");
  read(0, buf, 2uLL);
  if ( buf[0] == 110 )
  {
    puts("You r troublesome...Why do this boring thing again!?");
    sub_400999();
  }
}

void sub_400A22()
{
  char buf[264];

  puts("Oh,man.Play with the stack is really dangerous,so u can only play once..");
  if ( !dword_602060 )
  {
    dword_602060 = 1;
    read(0, buf, 0x1000uLL);
    puts(buf);
  }
}

void sub_400A9B()
{
  char s[8];

  puts("This is a really powerful weapon...(to leak the secret code I think?)");
  memset(s, 0, sizeof(s));
  read(0, s, 2uLL);
  printf(s, 1LL);
}

void __fastcall __noreturn main(__int64 a1, char **a2, char **a3)
{
  int v3;
  char s[24];

  sub_400842();
  while ( 1 )
  {
    while ( 1 )
    {
      printf("Guess your option:");
      memset(s, 0, 0x10uLL);
      read(0, s, 0x10uLL);
      v3 = atoi(s);
      if ( v3 != 2 )
        break;
      sub_400999();
    }
    if ( v3 > 2 )
    {
      if ( v3 == 3 )
      {
        sub_400A9B();
      }
      else if ( v3 == 9011 )
      {
        sub_4008A3();
      }
      else
      {
LABEL_13:
        puts("haha");
      }
    }
    else
    {
      if ( v3 != 1 )
        goto LABEL_13;
      sub_400A22();
    }
  }
}
