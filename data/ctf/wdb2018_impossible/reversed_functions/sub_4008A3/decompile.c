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